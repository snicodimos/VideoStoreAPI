Rails.application.routes.draw do

  resources :customers, only: [:index]
  resources :movies, only: [:index, :show, :create]

  post '/rentals/check-in', to: 'rentals#checkin', as: 'checkin'

  post '/rentals/check-out', to: 'rentals#checkout', as: 'checkout'


  # get '/zomg', to: 'customers#index'

end
