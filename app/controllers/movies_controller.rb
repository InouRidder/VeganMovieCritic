require 'json'
require 'open-uri'

class MoviesController < ApplicationController
  before_action :find_movie, only: [:show, :edit, :update, :destroy, :partial]
  before_action :disable_nav, only: [:partial]
  before_action :find_user, only: [:show, :pending, :index, :rated, :show, :alphabetical]
  skip_before_action :authenticate_user!, only: [:index, :show, :partial, :highrated, :top10, :most_reviewed, :newest, :rated, :alphabetical]

  def index
    @movies = policy_scope(Movie).order(created_at: :desc)
  end

  def show
    array = @movie.reviews.where(approved: true)
    array.each do |review|
      review.set_rating
      review.save!
    end
    @reviews = @movie.reviews.where(approved: true).order(review_rating: :desc)
  end

  def new
    @movie = Movie.new
    authorize @movie
  end

# IDEA : Call method on data to remove all this logic from controller. It's hideous.
  def create
    if @movie = Movie.all.find_by_title(params["movie"]["title"].strip)
      authorize @movie
      redirect_to select_path(@movie)
    else
      search_query = params["movie"]["title"]
      url = "http://www.omdbapi.com/?t=#{search_query}&y=&plot=short&r=json"
      returned_data = open(url).read
      data = JSON.parse(returned_data)
      if data["Response"] == "False"
        authorize Movie.new
        redirect_to movies_custom_new_path
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
          redirect_to select_path(@movie)
        end
      end
    end
  end

  def select
    @movie = Movie.find(params[:format])
    authorize @movie
  end

  def custom_new
    @movie = Movie.new
    authorize @movie
  end

  def custom_create
    @movie = Movie.new(movie_params)
    @movie.save!
    authorize @movie
    redirect_to new_movie_review_path(@movie)
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

  def results
    @movies = Movie.search_title(params[:title])
    authorize (Movie.first)
  end

  def partial
    @review = @movie.reviews.where(approved: :true).where.not(rating: nil).order(review_rating: :desc).first
    @user = current_user
    if @review && current_user
      @review_rating = ReviewRating.where(review_id: @review.id).where(user_id: @user.id).first || ReviewRating.new
    end
    render :layout => false
  end

  def highrated
    reviews = Review.where(approved: true)
    reviews.each do |review|
      review.set_rating
      review.save!
    end
    @highest_reviews = Review.where.not(approved: nil).order(rating: :desc)
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
    @movies = Movie.order(rating: :desc)[0..9]
    @review_rating = ReviewRating.new
    authorize (Movie.first)
  end

  def most_reviewed
      movies = Movie.all
      movies.each do |e|
        e.set_times_reviewed
      end
      @movies = Movie.order(times_reviewed: :desc)[0..9]
      authorize (Movie.first)
    end

    def newest
      @newest_reviews = Review.where(approved: true).order(created_at: :desc)[0..9]
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
      params.require(:movie).permit(:title, :country, :actors, :released)
    end
  end
