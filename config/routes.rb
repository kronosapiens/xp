Rails.application.routes.draw do

  root "lessons#index"

  resources :lessons do
    resources :comments, only: [:create, :destroy]
    resources :registrations, only: [:create, :update, :destroy]
  end

  patch "/lessons/:id/status" => "lessons#update_status", as: :update_status

  resources :tags, only: [:new, :create]

# Routes for user authentication
  get "/auth/github" => "auth#github", as: :login
  get "/auth/:provider/callback" => "sessions#oauth"
  get "/logout" => "sessions#destroy", as: :logout

# Routes for user interactions
  get "/users/:nickname" => "users#show", as: :user
  
end
