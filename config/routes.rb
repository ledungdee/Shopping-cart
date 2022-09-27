Rails.application.routes.draw do

  root "static_pages#home"
  get "/help",    to: "static_pages#help"
  get "/blog",    to: "static_pages#blog"
  get "/contact", to: "static_pages#contact"
  get "/about",   to: "staic_pages#about"
  get "/signup",  to: "users#new"
  get    "/login",      to: "sessions#new"
  post   "/login",      to: "sessions#create"
  delete "/logout",     to: "sessions#destroy"



  resources :users
  resources :shops
  resources :products 
  resources :cart_items
  resources :cart_sessions


  post '/products/:id/add_to_cart', to: 'cart_items#create', as: 'add_to_cart'
  # post '/products/:id/cart', to: 'cart_items#create', as: 'add_to_cart'
  patch '/update_quantity', to: 'cart_items#update_quantity'
end
