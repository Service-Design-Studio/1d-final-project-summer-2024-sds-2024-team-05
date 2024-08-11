# # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  resources :meetings
  devise_for :users

  authenticated :user, lambda { |u| !u.admin? } do
    root 'patients#index', as: :user_root
  end

  authenticated :user, lambda { |u| u.admin? } do
    root 'admins#index', as: :admin_root
  end

  # For non-authenticated users, redirect them to a specific page, like a login page or a welcome page
  devise_scope :user do
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :assessments, only: [:edit, :update]



  get '/search', to: "admins#search"

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
      get 'edit_physical_assessment', to: 'admins#_physical_assessment'
      patch 'edit_physical_assessment', to: 'admins#update_physical_assessment'
      get 'edit_mental_assessment', to: 'admins#_mental_assessment'
      patch 'edit_mental_assessment', to: 'admins#update_mental_assessment'
      get 'edit_environment_assessment', to: 'admins#_environment_assessment'
      patch 'edit_environment_assessment', to: 'admins#update_environment_assessment'
      get 'client_profile', to: 'admins#client_profile'
      patch 'client_profile', to: 'admins#update_client_profile'

      get 'edit_patient_assessment', to: 'admins#_patient_assessment'
      patch 'edit_patient_assessment', to: 'admins#update_patient_assessment'

      get 'physical_assessment', to: 'assessments#physical', as: 'physical_assessment'

      patch 'update_submission_status', to: 'patients#update_submission_status'
      post 'generate_signed_url', to: 'patients#generate_signed_url'
    end

    collection do
      get 'edit_1', to: 'patients#edit_1'
      post 'edit_1', to: 'patients#update_1_collection'
      get 'edit_2', to: 'patients#edit_2'
      post 'edit_2', to: 'patients#update_2_collection'
      get 'edit_3', to: 'patients#edit_3'
      post 'edit_3', to: 'patients#update_3_collection'
      get 'edit_4', to: 'patients#edit_4'
      post 'edit_4', to: 'patients#update_4_collection'
      get 'edit_5', to: 'patients#edit_5'
      post 'edit_5', to: 'patients#update_5_collection'
      get 'show_error', to: 'patients#show_error'
    end
  end
end
