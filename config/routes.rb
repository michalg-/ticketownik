Rails.application.routes.draw do
  root 'projects#index'

  resources :projects do
    resources :tickets, controller: 'projects/tickets'
    resources :users, controller: 'projects/users'
  end

  resources :sessions, only: [:new, :destroy]
  resource :user, only: [:edit, :update]

  namespace :api do
    resources :projects, except: [:new, :edit] do
      resources :tickets, controller: 'projects/tickets' do
        resources :comments, controller: 'projects/tickets/comments'
      end
      resources :users, only: [:index, :destroy], controller: 'projects/users' do
        delete :destroy, on: :collection
      end
    end
    resources :sessions, only: [:create]
    resource :user, only: [:show, :update]
  end

  #user-friendly sessions paths
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  delete '/logout' => 'sessions#destroy'
end
