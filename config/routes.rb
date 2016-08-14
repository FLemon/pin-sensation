Rails.application.routes.draw do
  devise_for :users
  mount ActionCable.server => '/cable'

  resources :chatrooms
  resources :messages
  resource :list, only: [:show]
  resource :item, only: [:create, :destroy]

  root 'lists#show'
end
