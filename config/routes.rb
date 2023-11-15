Rails.application.routes.draw do
  root 'chats#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to:'users#new'
  post 'signup', to:'users#create'

  resource :message, only: [:create]

  get 'search', to: 'users#search'
  resources :users, only: [:index]
  resources :friend_requests, only: [:create, :index, :destroy, :update]

  get 'chat/:chat_id', to: 'chats#show', as: 'chat'
  get 'chatroom-ids', to: 'chats#chat_ids'
  # resource :chats, only: [:show, :index]
  post 'new_direct_message', to: 'direct_messages#create'


  mount ActionCable.server => '/cable'
end
