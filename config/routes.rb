Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
    resources :review_ratings, only: [:create, :new, :edit, :update]

    get 'movies/:id/partial', to: 'movies#partial'
    get 'movies/newest', to: 'movies#newest'
    get 'movies/highrated', to: 'movies#highrated'
    get 'movies/pending', to: 'movies#pending'
    get 'movies/pending/approve/', to: 'reviews#approve'

    resources :movies do
      resources :reviews
    end
  root to: 'home#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
