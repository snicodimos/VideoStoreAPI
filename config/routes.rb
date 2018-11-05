Rails.application.routes.draw do

  resources :customers, only: [:index]
  resources :movies, only: [:index, :show, :create]

  # get '/zomg', to: 'customers#index'

end
