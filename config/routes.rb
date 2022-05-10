Rails.application.routes.draw do
  apipie
  devise_for :users, defaults: { format: :json }, controllers: {
    sessions: 'auth/sessions',
    registrations: 'auth/registrations'
  }, skip: [:confirmation, :password]

  devise_scope :user do
    resource :confirmation, path: 'users/confirmation', module: :auth, only: [:show, :create]
    resource :password, path: 'users/password', module: :auth, only: [:create, :update] do
      get 'edit'
    end
  end
    # get 'users/confirmation', to: 'auth/confirmations#show'
    # post 'users/confirmation', to: 'auth/confirmations#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'hello', to: 'greets#create'
end
