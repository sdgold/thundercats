Rails.application.routes.draw do
  root to: 'home#index'

  get 'login', to: 'user_sessions#new', as: :login
  delete 'logout' => 'user_sessions#destroy', as: :logout

  resources :users
  resources :user_sessions

  resources :books
  resources :posts
  resources :coordinators

  resources :buildings
end