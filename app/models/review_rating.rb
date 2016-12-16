class ReviewRating < ApplicationRecord
  belongs_to :review, :user
end
