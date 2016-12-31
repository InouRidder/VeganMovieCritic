require 'json'
require 'open-uri'

class MoviesController < ApplicationController
  before_action :find_movie, only: [:show, :edit, :update, :destroy, :partial]
  before_action :disable_nav, only: [:partial]
  before_action :find_user, only: [:pending, :index, :rated, :show, :alphabetical]

  def index
    @movies = policy_scope(Movie).order(created_at: :desc)
  end

  def show
    array = @movie.reviews.where(approved: true)
    array.each do |review|
      review.set_rating
      review.save!
    end
    @reviews = @movie.reviews.where(approved: true).order(rating: :desc)
    @review_rating = ReviewRating.new
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
    @review = @movie.reviews.where(approved: :true).order(rating: :desc)[0]
    @review_rating = ReviewRating.new
    @buser = current_user
  end

  def highrated
    reviews = Review.where(approved: true)
    reviews.each do |review|
      review.set_rating
      review.save!
    end
    @highest_reviews = Review.where(approved: true).order(rating: :desc)
    @highest_reviews
    authorize (Movie.first)
    # array of highest user_rating reviews
  end

  def top10
    movies = Movie.all
    movies.each do |movie|
      movie.rating = movie.set_rating
      movie.save!
    end
    @top_movies = Movie.order(rating: :desc)[1..10]
    @review_rating = ReviewRating.new
    authorize (Movie.first)
  end


  def newest
    @newest_reviews = Review.where(approved: true).order(created_at: :desc)
    authorize (Movie.first)
  end

  def pending
    @pending_reviews = Review.where(approved: false)
    authorize (Movie.first)
  end

  def rated
    @movies = Movie.order(rating: :desc)
    authorize (Movie.first)
  end

  def alphabetical
    @movies = Movie.order(:title)
    authorize (Movie.first)
  end

  private

  def find_user
    @user = current_user
  end

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
