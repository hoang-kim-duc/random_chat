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
  # resources :users, only: [:show]
  resource :messages, only: :create
  resource :enqueuing, module: :pairing, only: %i[create destroy]
  resource :identity, only: :show
  # below is just routes for the POCs
  get 'hello', to: 'greets#create'
  post 'add_user', to: 'greets#add_user'
  post 'show', to: 'greets#show'
end
