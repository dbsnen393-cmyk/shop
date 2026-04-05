Rails.application.routes.draw do
  resources :products
  resources :carts, only: [:show, :destroy]
  resources :line_items, only: [:create, :destroy]
  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  root 'products#index'
end
