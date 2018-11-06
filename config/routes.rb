Rails.application.routes.draw do

  resources :customers, only: [:index]
  resources :movies, only: [:index, :show, :create]

  post '/rentals/checkin', to: 'rentals#checkin'

  post '/rentals/checkout', to: 'rentals#checkout'

  # get '/zomg', to: 'customers#index'

end
