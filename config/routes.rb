Rails.application.routes.draw do
  default_url_options host: (ENV['HOST'] || 'localhost:3000')
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
  resource :messages, only: :create
  resource :enqueuing, only: [:create, :destroy]
  # below is just routes for the POCs
  get 'hello', to: 'greets#create'
  post 'add_user', to: 'greets#add_user'
  post 'show', to: 'greets#show'

end
