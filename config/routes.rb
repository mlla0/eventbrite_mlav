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

  namespace :admins do
    resources :admin, only: [:index]
  	resources :users, only: [:index, :destroy]
    resources :event_submissions, only: [:index, :update, :show]
    resources :events, only: [:index, :destroy]
  	root to: "admin#index"
  end
end
