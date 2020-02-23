Rails.application.routes.draw do

  get 'relationships/create'
  get 'relationships/destroy'
  root to: 'tasks#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  
  resources :users, only: [:show, :new, :create] do
    member do
      get :likes
      get :subjects
    end
  end
  
  resources :tasks
  resources :relationships, only: [:create, :destroy]
end