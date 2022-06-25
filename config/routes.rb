Rails.application.routes.draw do
  #get 'toppages/index'
  #get 'sessions/new'
  #get 'sessions/create'
  #get 'sessions/destroy'
  #get 'users/index'
  #get 'users/show'
  #get 'users/new'
  #get 'users/create'

  root to: 'tasks#index'
  #root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :tasks
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :create]
  #resources :users, only: [:index, :show, :create]
  #resources :tasks, only: [:index, :create, :destroy]
end
