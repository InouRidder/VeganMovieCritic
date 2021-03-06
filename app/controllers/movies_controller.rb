class MoviesController < ApplicationController
  before_action :find_movie, only: [:show, :edit, :update, :destroy, :partial]
  before_action :disable_nav, only: [:partial]
  before_action :find_user, only: [:show, :pending, :index, :rated, :show,]
  skip_before_action :authenticate_user!, only: [:index, :show, :partial, :highrated, :top10, :most_reviewed, :newest, :rated]

  def index
    @active = 'newest-b'
    @movies = policy_scope(Movie).order(created_at: :desc)
    @movie = @movies[0]
    partial(@movie) if @movie
  end

  def show
    @reviews = @movie.reviews.approved.order(review_rating: :desc)
    respond_to do |format|
      format.html
      format.js {
        partial(@movie)
      }
    end
  end

  def new
    @movie = Movie.new
    authorize @movie
  end

  def create
    title = movie_params["title"]
    if @movie = Movie.find_by_title(title.strip)
      authorize @movie
      redirect_to select_path(movie_id: @movie.id)
    elsif @movie = Movie.search_movie(title)
      authorize @movie
      redirect_to select_path(movie_id: @movie.id)
    else
      authorize Movie.new
      flash[:alert] = "Could not find movie in database"
      redirect_to movies_custom_new_path
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
    @movie.title = @movie.title.strip
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



  def top10
    # no older than september 2016
    @movies = Movie.top10
    @movie = @movies[0]
    @active = 'top10'
    partial(@movie) if @movie
    @review_rating = ReviewRating.new
    authorize (Movie.first)
    render :index
  end

  def newest
    @newest_reviews = Review.all.newest
    authorize (Movie.first)
  end

  def most_reviewed
    @active = 'most_reviewed'
    @movies = Movie.most_reviewed
    @movie = @movies[0]
    partial(@movie) if @movie
    authorize (@movie)
    render :index
  end

  def pending
    @pending_reviews = Review.unapproved
    authorize (Movie.first)
  end

  def rated
    @active = 'rated'
    @movies = Movie.by_rating.reject { |movie| movie.rating.nil? }
    @movie = @movies[0]
    partial(@movie) if @movie
    authorize (Movie.first)
    render :index
  end

  private

  def partial(movie)
    @review = movie.reviews.approved.order(review_rating: :desc).first
    @user = current_user
    if @review && current_user
      @review_rating = ReviewRating.find_by(review_id: @review.id, user_id: @user.id) || ReviewRating.new
    end
  end

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
