Rails.application.routes.draw do
  root to: 'home#index'

  get 'login', to: 'user_sessions#new', as: :login

  resources :users
  resources :user_sessions
end