Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
    resources :review_ratings, only: [:create, :new, :edit, :update]

    get '/movies/:id/partial', to: 'movies#partial'
    get '/movies/newest', to: 'movies#newest'
    get '/movies/highrated', to: 'movies#highrated'
    get '/movies/pending', to: 'movies#pending'
    get '/movies/pending/approve', to: 'reviews#approve'
    get '/home', to: 'home#home'
    get '/movies/2016', to: 'movies#top10'
    get '/movies/alphabetical', to: 'movies#alphabetical'
    get '/movies/rated', to: 'movies#rated'
    get '/movies/most-reviewed', to: 'movies#most_reviewed'
    get '/movies/results', to: 'movies#results'

    resources :movies do
      resources :reviews
    end
  root to: 'home#landing'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
