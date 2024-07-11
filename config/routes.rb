require 'active_storage/engine'
Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'patients#index', as: :user_root
  end

  authenticated :admin do
    root 'patients#dashboard', as: :admin_root
  end

  get 'patients/dashboard', to: 'patients#dashboard', as: :patients_dashboard

  get '/search', to: "patients#search"

  # get 'patients/new'
  # get 'patients/edit'
  # get 'patients/show'
  # get 'patients/index'
  # # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # # Services
  # get "services/service"
  # get "services/welcomenew"=> 'services#newtask'
  # get "services/signup"
  # get "services/envpics"
  # get "services/login"

  # # Photo and Video uploading
  # get 'photos/new'
  # get 'photos/create'
  # get 'videos/new'
  # get 'videos/create'
  # get 'photos/new', to: 'photos#new', as: 'new_photos'

  # # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # # Forms
  # get "forms" => "forms/index"
  # get "forms/summary", to: "forms#summary"
  # get "forms/med_cond", to: "forms#med_cond"
  # get "forms/personal", to: "forms#personal"
  # get "forms/serv_req", to:"forms#serv_req"



  # resources :videos, only: [:new, :create]
  # resources :photos, only: [:new, :create]
  # root 'services#service'

  resources :forms, controller: 'patients' do
    member do
      get 'edit_1', to: 'patients#edit_1'
      patch 'edit_1', to: 'patients#update_1'
      get 'edit_2', to: 'patients#edit_2'
      patch 'edit_2', to: 'patients#update_2'
      get 'edit_3', to: 'patients#edit_3'
      patch 'edit_3', to: 'patients#update_3'
      get 'edit_4', to: 'patients#edit_4'
      patch 'edit_4', to: 'patients#update_4'
      get 'edit_5', to: 'patients#edit_5'
      patch 'edit_5', to: 'patients#update_5'
      get 'edit_physical_assessment', to: 'patients#physical_assessment'
      patch 'edit_physical_assessment', to: 'patients#update_physical_assessment'
      get 'edit_mental_assessment', to: 'patients#mental_assessment'
      patch 'edit_mental_assessment', to: 'patients#update_mental_assessment'
      get 'edit_environment_assessment', to: 'patients#environment_assessment'
      patch 'edit_environment_assessment', to: 'patients#update_environment_assessment'
      patch 'update_submission_status', to: 'patients#update_submission_status'

#       patch :update_status



    end
    collection do
      get 'edit_1', to: 'patients#edit_1'
      patch 'edit_1', to: 'patients#update_1_collection'
      get 'edit_2', to: 'patients#edit_2'
      patch 'edit_2', to: 'patients#update_2_collection'
      get 'edit_3', to: 'patients#edit_3'
      patch 'edit_3', to: 'patients#update_3_collection'
      get 'edit_4', to: 'patients#edit_4'
      patch 'edit_4', to: 'patients#update_4_collection'
      get 'edit_5', to: 'patients#edit_5'
      patch 'edit_5', to: 'patients#update_5_collection'
      get 'edit_physical_assessment', to: 'patients#physical_assessment'
      patch 'edit_physical_assessment', to: 'patients#update_physical_assessment_collection'
      get 'edit_mental_assessment', to: 'patients#mental_assessment'
      patch 'edit_mental_assessment', to: 'patients#update_mental_assessment_collection'
      get 'edit_environment_assessment', to: 'patients#environment_assessment'
      patch 'edit_environment_assessment', to: 'patients#update_environment_assessment_collection'
      get 'show_error', to: 'patients#show_error'
    end
  end
  root 'patients#index'
  get 'back_to_previous', to: 'patients#back_to_previous', as: 'back_to_previous'
end
