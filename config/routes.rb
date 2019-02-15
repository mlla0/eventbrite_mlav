Rails.application.routes.draw do
  namespace :admins do
    get 'admin/index'
  end
  devise_for :users
  root 'events#index'
  resources :events do
  	resources :attendances, only: [:new, :create, :index]
  	resources :event_pictures, only: [:create]
  end
  resources :users, only: [:show, :edit, :update] do
  	resources :avatars, only: [:create]
  end

  namespace :admins do
    resources :admin, only: [:index]
  	resources :users
  	root to: "admin#index"
  end
end
