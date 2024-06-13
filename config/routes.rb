Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "form" => "form/index"
  # root "form#index"
  # root "form#med_cond"
  # root "form#serv_req"
  get "summary", to: "form#summary"
  get "med_cond", to: "form#med_cond"
  get "personal", to: "form#personal"
  get "serv_req", to:"form#serv_req"

  # Defines the root path route ("/")
  # root "posts#index"
end
