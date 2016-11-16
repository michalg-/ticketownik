Rails.application.routes.draw do
  root 'home#show'

  resources :projects do
    resources :tickets, controller: 'projects/tickets'
  end

  resources :sessions, only: [:new, :destroy]

  namespace :api do
    resources :projects, except: [:new, :edit]
    resources :sessions, only: [:create]
  end


  #user-friendly sessions paths
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  delete '/logout' => 'sessions#destroy'
end
