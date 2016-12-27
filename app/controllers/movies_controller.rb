require 'json'
require 'open-uri'

class MoviesController < ApplicationController
  before_action :find_movie, only: [:show, :edit, :update, :destroy, :partial]
  before_action :disable_nav, only: [:partial]

  def index
    @movies = policy_scope(Movie).order(created_at: :desc)
    @user = current_user
  end

  def show
    @reviews = @movie.reviews
    @review_rating = ReviewRating.new
    @user = current_user
  end

  def new
    @movie = Movie.new
    authorize @movie
  end

  def create
    search_query = params["movie"]["title"]
    url = "http://www.omdbapi.com/?t=#{search_query}&y=&plot=short&r=json"
    returned_data = open(url).read
    data = JSON.parse(returned_data)
      if @movie = Movie.all.find_by_title(data["Title"])
        authorize @movie
        redirect_to new_movie_review_path (@movie)
      else
        @movie = Movie.new
        @movie.title = data["Title"]
        @movie.released = data["Released"]
        @movie.runtime = data["Runtime"]
        @movie.genre = data["Genre"]
        @movie.plot = data["Plot"]
        @movie.actors = data["Actors"]
        @movie.awards = data["Awards"]
        @movie.poster = data["Poster"]
        @movie.imdbrating = data["imdbrating"]
        authorize @movie
          if @movie.save!
            redirect_to new_movie_review_path(@movie)
          end
      end
  end

  def edit
    @movie.title = params["title"]
  end

  def update
    @movie.update(movie_params)
    @movie.save!
    redirect_to movies_path
  end

  def destroy
    @movie.destroy
    redirect_to movies_path
  end

  def partial
    @review = @movie.reviews[0]
    @review_rating = ReviewRating.new
    @user = current_user
  end

  def highrated
    # array of highest user_rating reviews
  end

  def newest
    # array of objects of newest approved reviews
  end

  def pending
    # array of still pending reviews...
  end

  private

  def disable_nav
    @disable_nav = true
  end

  def find_movie
    @movie = Movie.find(params[:id])
    authorize @movie
  end

  def movie_params
    params.require(:movie).permit(:title)
  end
end
