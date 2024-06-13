Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Services
  get "services/service"
  get "services/welcomenew"=> 'services#newtask'
  get "services/signup"
  get "services/envpics"
  get "services/login"
  
  # Photo and Video uploading
  get 'photos/new'
  get 'photos/create'
  get 'videos/new'
  get 'videos/create'
  get 'photos/new', to: 'photos#new', as: 'new_photos'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Forms
  get "form" => "form/index"
  get "summary", to: "form#summary"
  get "med_cond", to: "form#med_cond"
  get "personal", to: "form#personal"
  get "serv_req", to:"form#serv_req"


  # Defines the root path route ("/")
  # root "posts#index"
  resources :videos, only: [:new, :create]
  resources :photos, only: [:new, :create]
  root 'services#service'

end
