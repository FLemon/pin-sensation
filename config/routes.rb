Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  resources :chatrooms
  resources :messages
  resource :list, only: [:show]
  resource :item, only: [:create, :destroy]

  root 'chatrooms#index'
end
