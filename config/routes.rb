Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :available_hours
      resources :capabilities
      resources :equipment
      resources :equipment_capabilities
      resources :equipment_materials
      resources :labs
      resources :lab_spaces
      resources :materials
      resources :reservations

      root to: "users#index"
    end
  devise_for :users
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

  root 'home#landing'
end
