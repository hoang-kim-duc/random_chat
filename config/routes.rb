# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  default_url_options host: (ENV['HOST'] || 'localhost:3000')
  apipie
  devise_for :users, defaults: { format: :json }, controllers: {
    sessions: 'auth/sessions',
    registrations: 'auth/registrations'
  }, skip: %i[confirmation password]

  devise_scope :user do
    resource :confirmation, path: 'users/confirmation', module: :auth, only: %i[show create]
    resource :password, path: 'users/password', module: :auth, only: %i[create update] do
      get 'edit'
    end
    resource :user_setting, only: [:show], module: :pairing do
      post 'update_or_create'
    end
  end
  resources :users, module: :users, only: [] do
    resources :posts, only: [:index]
  end
  resources :users, only: :show
  resources :posts, only: [:index, :create, :update, :destroy] do
    post 'toggle_react', to: 'posts#toggle_react', on: :member
  end
  resources :conversations, module: :chat, only: [:index] do
    resources :messages, only: [:create, :index]
    put 'seen', to: 'conversations#seen_all'
    put 'share_profile', to: 'conversations#share_profile'
  end
  resource :enqueuing, module: :pairing, only: %i[create destroy]
  resource :identity, only: :show
  resources :reports, only: :create
  namespace "admin" do
    resources :reports, only: [:index] do
      put :resolve, on: :member
    end
    resources :users, only: [:index]
  end
  resources :partners, only: [:index]
  # below is just routes for the POCs
  get 'hello', to: 'greets#create'
  post 'add_user', to: 'greets#add_user'
  post 'show', to: 'greets#show'
end
