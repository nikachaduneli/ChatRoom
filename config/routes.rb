Rails.application.routes.draw do
  root 'chatroom#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to:'users#new'
  post 'signup', to:'users#create'

  resource :message, only: [:create]

  get 'search', to: 'users#search'
  resource :users, only: [:index]


  mount ActionCable.server => '/cable'
end
