Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :labs do
    resources :lab_spaces do
      resources :equipment
    end
  end
  
  root 'home#landing'
end
