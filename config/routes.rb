Rails.application.routes.draw do
  get 'new/edit'
  get 'new/destroy'
  get 'new/update'
  get 'microposts/new'
  get 'microposts/edit'
  get 'microposts/destroy'

  root "static_pages#home"
  get "/help",    to: "static_pages#help"
  get "/blog",    to: "static_pages#blog"
  get "/contact", to: "static_pages#contact"
  get "/about",   to: "staic_pages#about"

  get    "/signup",     to: "users#new"
  get    "/login",      to: "sessions#new"
  post   "/login",      to: "sessions#create"
  delete "/logout",     to: "sessions#destroy"
  get    "/logout",     to: "sessions#destroy"


  resources :users
  resources :shops
  resources :products 
  resources :cart_items, only: [:index, :create, :update_quantity, :destroy]
  resources :cart_sessions, only: [:show,:checkout]
  resources :orders

  post '/products/add_to_cart', to: 'cart_items#create', as: 'add_to_cart'
  patch '/update_quantity', to: 'cart_items#update_quantity'
  post '/cart_sessions/:id/order', to: 'cart_sessions#checkout', as: 'checkout'

  get '/user/new_addr', to: 'users#change_delivery_address', as: 'new_addr'
  patch '/user/new_addr', to: 'users#update_delivery_address', as: 'update_addr'
end
