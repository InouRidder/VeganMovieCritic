class AddUserReferenceToUserRating < ActiveRecord::Migration[5.0]
  def change
    add_reference :review_ratings, :user, foreign_key: true
  end
end
