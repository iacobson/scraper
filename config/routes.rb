Rails.application.routes.draw do

  resources :movies
  get 'pages/home'

  devise_for :users
  root to: "pages#home"


end
