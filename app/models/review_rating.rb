class ReviewRating < ApplicationRecord
  belongs_to :user
  belongs_to :review
  validates :rating, presence: true

  after_create :rerate_review

  def rerate_review
    self.review.set_rating
  end
end
