class MoviesController < ApplicationController
  before_action :find_movie, only: [:show, :edit, :update, :destroy, :partial]
  before_action :disable_nav, only: [:partial]
  before_action :find_user, only: [:show, :pending, :index, :rated, :show, :alphabetical]
  skip_before_action :authenticate_user!, only: [:index, :show, :partial, :highrated, :top10, :most_reviewed, :newest, :rated, :alphabetical]

  def index
    @movies = policy_scope(Movie).order(created_at: :desc)
  end

  def show
    Review.set_ratings(@movie.reviews.approved)
    @reviews = @movie.reviews.approved.order(review_rating: :desc)
  end

  def new
    @movie = Movie.new
    authorize @movie
  end

  def create
    title = params["movie"]["title"]
    if @movie = Movie.all.find_by_title(title.strip)
      authorize @movie
      redirect_to select_path(movie_id: @movie.id)
    else
      @movie = Movie.new
      if false #@movie = Movie.search_movie(title)
        authorize @movie
        redirect_to select_path(movie_id: @movie.id)
      else
        authorize Movie.new
        flash[:alert] = "Could not find movie in databse"
        redirect_to movies_custom_new_path
      end
    end
  end


  def select
    @movie = Movie.find(params[:movie_id])
    authorize @movie
  end

  def custom_new
    if params[:format]
      @movie = Movie.find(params[:movie_id])
      unless @movie.reviewed?
        @movie.destroy
      end
    end
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
    @review = @movie.reviews.approved.order(review_rating: :desc).first
    @user = current_user
    if @review && current_user
      @review_rating = ReviewRating.where(review_id: @review.id).where(user_id: @user.id).first || ReviewRating.new
    end
    render :layout => false
  end

  def top10
    # no older than september 2016
    Movie.set_ratings
    @movies = Movie.top10
    @review_rating = ReviewRating.new
    authorize (Movie.first)
  end

  def most_reviewed
    Movie.set_times_reviewed
    @movies = Movie.most_reviewed
    authorize (Movie.first)
  end

  def newest
    @newest_reviews = Review.all.newest
    authorize (Movie.first)
  end

  def pending
    @pending_reviews = Review.unapproved
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
    params.require(:movie).permit(:title, :country, :actors, :released, :poster, :poster, :poster_cache)
  end
end
