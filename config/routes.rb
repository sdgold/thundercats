Rails.application.routes.draw do
  get 'user_sessions/new'
  root to: 'home#index'

  resources :users
  resources :user_sessions
end