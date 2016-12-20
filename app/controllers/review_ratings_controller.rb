class ReviewRatingsController < ApplicationController
  before_action: :find_user_id, only: [:create, :update, :edit]
  before_action: :find_review_id, only: [:create, :update, :edit]

  def new
    @review_rating = ReviewRating.new
  end

  def create
    @review_rating = ReviewRating.new(review_params)
    @review_rating.save!
    redirect_to movie_path
  end

  def edit
  end

  def update
    @review_rating.update(review_params)
    @review_rating.save!
    redirect_to movie_path
  end

  def destroy
    @review_rating.destroy
    redirect_to movie_path
  end

  private

  def find_user_id
    @user_id = current_user.id
  end

  def find_review_id
    @review_id = params[:review_id]
  end

  def review_params
    params.require(:review_rating).permit(:rating, :user_id, :review_id)
end
