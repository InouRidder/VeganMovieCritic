class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  has_many :review_ratings

  private

  def user_rating
    self.review_ratings.reduce(:+).to_f / self.review_ratings.size
  end
end
