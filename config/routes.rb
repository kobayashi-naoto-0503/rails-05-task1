Rails.application.routes.draw do
  get 'profiles/new'
  get 'profile/new'
  get 'sessions/new'
  root 'pages#index'
  get 'pages/help'
  get 'pages/link'
  resources :users
  resources :topics
  resources :profiles
  
  get 'login', to:'sessions#new'
  post 'login', to:'sessions#create'
  delete 'logout', to:'sessions#destroy'
  
  get 'favorites/index'
  post '/favorites', to: 'favorites#create'
  delete '/favorites', to: 'favorites#destroy'
  
  get '/comments/:topic_id/new', to: 'comments#new', as: 'comments'
  post '/comments/:topic_id/create', to: 'comments#create', as: 'comments_create'
end