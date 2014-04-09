Rails.application.routes.draw do

  root "lessons#index"

  resources :lessons do
    resources :comments, only: [:create, :destroy]
    resources :registrations, only: [:create, :update, :destroy]
  end

  patch "/lessons/:id/status" => "lessons#update_status", as: :update_status

  post "/lessons/:id/admin_email" => "lessons#admin_email"

  resources :tags, only: [:index, :new, :create]
  get "tags/:slug" => "tags#show", as: :tag

# Routes for user authentication
  get "/auth/github" => "auth#github", as: :login
  get "/auth/:provider/callback" => "sessions#oauth"
  get "/logout" => "sessions#destroy", as: :logout

# Routes for user interactions
  get "/users/:nickname" => "users#show", as: :user
  get "/users/:nickname/edit" => "users#edit", as: :edit_user

  post "/users/:nickname/update" => "users#update", as: :update_user
  
end
