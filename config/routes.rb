Rails.application.routes.draw do
  root 'chatroom#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to:'users#new'
  post 'signup', to:'users#create'

  resource :message, only: [:create]

  get 'search', to: 'users#search'
  resources :users, only: [:index]
  resources :friend_requests, only: [:create, :index, :destroy, :update]

  mount ActionCable.server => '/cable'
end
