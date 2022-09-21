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




  patch '/products/:id/editQuantity', to: 'products#updateQuantity'
  resources :users
  resources :shops
  resources :products 
end
