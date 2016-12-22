class MoviesController < ApplicationController
  before_action :find_movie, only: [:show, :edit, :update, :destroy]
  before_action :disable_nav, only: [:show]

  def index
    @movies = policy_scope(Movie).order(created_at: :desc)
    # @movies = Movie.all
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
    @movie = Movie.new(movie_params)
    authorize @movie
    if @movie.save!
      redirect_to movie_path(@movie)
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

  private

  def disable_nav
    @disable_nav = true
  end

  def find_movie
    @movie = Movie.find(params[:id])
    authorize @movie
  end

  def movie_params
    params.require(:movie).permit(:title, :rating)
  end
end
