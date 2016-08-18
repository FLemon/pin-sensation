Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  mount ActionCable.server => '/cable'

  resources :chatrooms
  resources :messages
  resource :list, only: [:show]
  resource :item, only: [:create, :destroy]

  root 'lists#show'
end
