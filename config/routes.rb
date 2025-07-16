Rails.application.routes.draw do
  root "static_pages#home"

  # Team page
  get "/team", to: "static_pages#team"

  # Contact page
  get "/contact", to: "static_pages#contact"

  # Landing page
  get "/welcome/:first_name", to: "static_pages#welcome"

  # Login/logout
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Gossips
  resources :gossips

  # Users
  resources :users

  # Cities
  resources :cities, only: [ :show ]

  # Comments
  resources :gossips do
    resources :comments
  end
end
