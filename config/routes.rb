Rails.application.routes.draw do
  get 'users/new'
  root 'pages#index'
  get 'pages/help'
  get 'pages/link'
end