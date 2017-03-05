class ReviewRating < ApplicationRecord
  belongs_to :user
  belongs_to :review
  validates :rating, presence: true
end
