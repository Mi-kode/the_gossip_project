Rails.application.routes.draw do
  root "static_pages#home"

  # Team page
  get '/team', to: 'static_pages#team'

  # Contact page
  get '/contact', to: 'static_pages#contact'

  # Landing page
  get '/welcome/:first_name', to: 'static_pages#welcome'

  # Gossips
  resources :gossips, only: [:new, :create, :show]

  # Users
  resources :users, only: [:show]

  # Cities
  ressources :cities, only: [:show]
end