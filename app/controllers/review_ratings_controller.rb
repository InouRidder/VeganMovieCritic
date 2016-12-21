class ReviewRatingsController < ApplicationController
  before_action :find_user_id, only: [:create, :update, :edit]
  before_action :find_review_id, only: [:create, :update, :edit]

  def new
    @review_rating = ReviewRating.new
  end

  def create
    @review_rating = ReviewRating.new(review_params)
    @review_rating.user_id = @user_id
    @review_rating.review_id = @review_id
    authorize @review_rating
    @review_rating.save!
    redirect_to movie_path(@review_rating.review.movie)
  end

  def edit
  end

  def update
    @review_rating.update(review_params)
    @review_rating.user_id = @user.id
    @review_rating.review_id = @review_id
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

  def find_user_id
    @user_id = current_user.id
  end

  def find_review_id
    @review_id = params["review_rating"]["review"].to_i
  end

  def review_params
    params.require(:review_rating).permit(:rating)
  end
end
