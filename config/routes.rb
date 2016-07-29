Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  resources :chatrooms
  resources :messages

  root 'chatrooms#index'
end
