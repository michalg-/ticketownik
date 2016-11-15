Rails.application.routes.draw do
  root 'home#show'

  resources :projects

  resources :sessions, only: [:new, :create, :destroy]
end
