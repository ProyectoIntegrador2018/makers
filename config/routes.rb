Rails.application.routes.draw do
  namespace :admin do
      resources :labs
      resources :lab_spaces
      resources :equipment
      resources :reservations
      resources :users
      resources :lab_administrations

      # Resources not shown on dashboard, but needed for forms
      resources :available_hours
      resources :capabilities
      resources :materials
      resources :equipment_capabilities
      resources :equipment_materials

      root to: "equipment#index"
  end

  devise_for :users, controllers: { registrations: "registrations" }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :labs do
    resources :lab_spaces do
      resources :equipment
    end
  end

  resources :equipment, only: [:index] do
    resources :reservations, except: [:edit]
  end

  resources :lab_spaces, only: [:index]

  authenticate :user do
    resources :reservations, except: [:new, :create, :index] do
      post 'confirm'
      post 'reject'
    end
  end

  get '/users', to: redirect('users/sign_up')
  get '/profile', to: 'home#profile'
  get '/home/related', to: 'home#related'
  get '/home/equipment_relation', to: 'home#equipment_relation'


  root 'home#landing'
end
