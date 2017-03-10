Rails.application.routes.draw do
  get 'profiles/index'

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  ActiveAdmin.routes(self)
  devise_for :users

    get '/movies/:id/partial', to: 'movies#partial'
    get '/movies/newest', to: 'movies#newest'
    get '/movies/highrated', to: 'movies#highrated'
    get '/movies/pending', to: 'movies#pending'
    get '/movies/pending/approve', to: 'reviews#approve'
    get '/home', to: 'home#home'
    get '/movies/2017', to: 'movies#top10'
    get '/movies/alphabetical', to: 'movies#alphabetical'
    get '/movies/rated', to: 'movies#rated'
    get '/movies/most-reviewed', to: 'movies#most_reviewed'
    get '/results', to: 'movies#results'
    get '/movies/custom_new', to: 'movies#custom_new'
    post '/movies/custom_create', to: 'movies#custom_create'
    get '/thankyou', to: 'home#thankyou'
    get '/select/', to: 'movies#select'

    resources :profiles

    resources :movies do
      resources :reviews do
        resources :review_ratings, only: [:create, :new, :edit, :update]
      end
    end
  root to: 'home#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
