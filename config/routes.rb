Rails.application.routes.draw do

  root "lessons#index"

  resources :lessons do
    resources :comments, only: [:create, :update, :destroy]
    resources :registrations, only: [:create, :update, :destroy]
  end

# Routes for user authentication
  get "/auth/github" => "auth#github", as: :login
  get "/auth/:provider/callback" => "sessions#oauth"
  get "/logout" => "sessions#destroy", as: :logout

# Routes for user interactions
  get "/users/:nickname" => "users#show", as: :user
  
end
