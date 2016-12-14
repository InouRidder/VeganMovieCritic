class AddReviewReferenceToUserRating < ActiveRecord::Migration[5.0]
  def change
        add_reference :review_ratings, :review, foreign_key: true
  end
end
