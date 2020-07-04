Rails.application.routes.draw do
  get 'buildings/index'
  root to: 'home#index'

  get 'login', to: 'user_sessions#new', as: :login

  resources :users
  resources :user_sessions

  resources :books
  resources :posts
  resources :coordinators
end