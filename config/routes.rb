Rails.application.routes.draw do
  devise_for :users
  root 'events#index'
  resources :events do
  	resources :attendances, only: [:new, :create, :index]
  	resources :event_pictures, only: [:create]
  end
  resources :users, only: [:show, :edit, :update] do
  	resources :avatars, only: [:create]
  end
end
