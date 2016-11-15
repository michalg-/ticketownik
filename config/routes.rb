Rails.application.routes.draw do
  root 'home#show'

  resources :projects
end
