Rails.application.routes.draw do
  resources :labs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#landing'
end
