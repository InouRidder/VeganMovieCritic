class ReviewsController < ApplicationController
  before_action :find_review, only: [:show, :edit, :update, :destroy]
  before_action :find_movie, only: [:edit, :update]
  before_action :find_user, only: [:create, :update]

  def show
    @review_rating = ReviewRating.new
  end

  def new
    @review = Review.new
    authorize @review
    @movie = Movie.find(params[:movie_id])
  end

  def create
    @review = Review.new(review_params)
    @review.movie_id = params[:movie_id]
    @review.user = @user
      if current_user.email == "stefan.wermenbol@gmail.com"
        @review.approved = true
      else
        @review.approved = false
      end
    authorize @review
    @review.save!
    redirect_to thankyou_path
  end

  def edit
  end

  def update
    @review.update(review_params)
    authorize @review
    @review.user = @user
    @review.save
    redirect_to movie_path(find_movie)
  end

  def approve
    @review = Review.find(params[:format])
    @review.approve
    @review.save!
    authorize @review
    redirect_to movies_pending_path
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
    authorize @review
  end

  def review_params
    params.require(:review).permit(:content, :rating, :title, :bootsy_image_gallery_id)
  end
end
