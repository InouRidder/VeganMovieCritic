class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  has_many :review_ratings


  def user_rating
    self.review_ratings != [] ? self.review_ratings.reduce(:+).to_f / self.review_ratings.size : "Not rated"
  end

end
