class ReviewRatingsController < ApplicationController
  before_action :set_review, only: [:create, :update, :edit]

  def new
    @review_rating = ReviewRating.new
  end

  def create
    @review_rating = ReviewRating.new(review_params)
    @review_rating.review = @review
    @review_rating.user = current_user
    authorize @review_rating
    @review_rating.save!
    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  def update
    @review_rating.update(review_params)
    @review_rating.user_id = @user.id
    @review_rating.review = @review
    authorize @review_rating
    @review_rating.save!
    redirect_to movie_path(@review_rating.review.movie)
  end

  def destroy
    @review_rating.destroy
    authorize @review_rating
    redirect_to movie_path(movie)
  end

  private

  def set_review
    @review = Review.find(params[:review_id])
  end

  def review_params
    params.require(:review_rating).permit(:rating)
  end
end
