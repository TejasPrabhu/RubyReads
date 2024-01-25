Rails.application.routes.draw do
  resources :transactions
  devise_for :users
  resources :books do
    resources :reviews
  end
  resources :members
  root 'books#index'
  get '/reviews', to: 'reviews#index', as: 'reviews'
  get '/reviews/:id', to: 'reviews#my_reviews', as: 'my_reviews'
  get '/cart', to: 'cart#index', as: 'cart'
  get '/cart/add', to:'cart#add_to_cart', as: 'add_to_cart'
  post '/cart', to:'cart#purchase_cart', as: 'purchase_cart'
  get '/cart/clear', to:'cart#clear_cart', as: 'clear_cart'
  get '/cart/:id', to:'cart#remove_from_cart', as:'remove_from_cart'
end
