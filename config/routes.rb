Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :products, only: [:index, :show]
  resources :categories, only: [:index]
  resources :price_lines, only: [:index]
end