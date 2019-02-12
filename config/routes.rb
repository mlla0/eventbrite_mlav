Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root 'events#index'
  resources :events, only: [:index, :new, :show, :create]
  resources :users, only: [:show, :edit, :update]
end
