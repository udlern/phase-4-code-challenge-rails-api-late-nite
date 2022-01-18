Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :episodes, only: [:index, :show]
  resources :guests, only: [:index]
  resources :appearances, only: [:create]
 
end
