Rails.application.routes.draw do
  root 'home#show'

  resources :projects

  resources :sessions, only: [:new, :create, :destroy]


  #user-friendly sessions paths
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  delete '/logout' => 'sessions#destroy'
end
