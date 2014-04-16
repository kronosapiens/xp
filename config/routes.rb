Rails.application.routes.draw do

  root "application#show"

  resources :lessons do
    resources :comments, only: [:create, :destroy]
    resources :registrations, only: [:create, :update, :destroy]
  end

  patch "/lessons/:id/status" => "lessons#update_status", as: :update_status

  post "/lessons/:id/admin_email" => "lessons#admin_email"

  resources :tags, only: [:index, :create]
  get "tags/:slug" => "tags#show", as: :tag

# Routes for user authentication
  get "/auth/github" => "auth#github", as: :login
  get "/auth/:provider/callback" => "sessions#oauth"
  get "/logout" => "sessions#destroy", as: :logout

# Routes for user interactions
  get "/users/:nickname/edit" => "users#edit", as: :edit_user
  get "/users/:nickname" => "users#show", as: :user
  post "/users/:nickname" => "users#update"
  get "/users/:nickname/update_xp" => "users#update_xp", as: :update_xp_user
  
end
