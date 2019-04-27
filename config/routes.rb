Rails.application.routes.draw do
  namespace :admin do
      resources :equipment
      resources :labs
      resources :lab_spaces
      resources :reservations
      resources :users
      resources :lab_administrations

      # Resources not shown on dashboard, but needed for forms
      resources :available_hours
      resources :capabilities
      resources :materials
      resources :equipment_capabilities
      resources :equipment_materials

      root to: "users#index"
  end

  devise_for :users, controllers: { registrations: "registrations" }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :labs do
    resources :lab_spaces do
      resources :equipment
    end
  end

  resources :equipment, only: [:index] do
    resources :reservations, except: [:show, :edit, :update, :destroy]
  end

  authenticate :user do
    resources :reservations, except: [:new, :create]
  end

  get '/users', to: redirect('users/sign_up')
  get '/profile', to: 'home#profile'

  root 'home#landing'
end
