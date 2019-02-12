Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root 'events#index'
  resources :events, only: [:index]
  resources :users, only: [:show]
end
