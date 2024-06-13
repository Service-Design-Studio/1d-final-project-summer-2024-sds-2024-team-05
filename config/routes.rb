Rails.application.routes.draw do
  get 'photos/new'
  get 'photos/create'
  get 'videos/new'
  get 'videos/create'
  get 'photos/new', to: 'photos#new', as: 'new_photos'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :videos, only: [:new, :create]
  resources :photos, only: [:new, :create]
  root 'videos#new'
end
