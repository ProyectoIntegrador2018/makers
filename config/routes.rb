Rails.application.routes.draw do
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
  
  root 'home#landing'
end
