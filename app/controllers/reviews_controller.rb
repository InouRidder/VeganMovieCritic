class ReviewsController < ApplicationController
  before_action :find_review, only: [:show, :edit, :update, :destroy]
  before_action :find_movie, only: [:edit, :update]
  before_action :find_user, only: [:create, :update]

  def show
  end

  def new
    @review = Review.new
    @movie = Movie.find(params[:movie_id])
  end

  def create
    @review = Review.new(review_params)
    @review.movie_id = params[:movie_id]
    @review.user = @user
    @review.save!
    redirect_to movie_path(Movie.find(params[:movie_id]))
  end

  def edit
  end

  def update
    @review.title = params["review"]["title"]
    @review.content = params["review"]["content"]
    @review.rating = params["review"]["rating"]
    @review.user = @user
    @review.save
    redirect_to movie_path(find_movie)
  end

  def destroy
    @review.destroy
    redirect_to movie_path(find_movie)
  end

  private

  def find_user
    @user = current_user
  end

  def find_movie
    @movie = Movie.find(params[:movie_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :rating, :title)
  end
end
