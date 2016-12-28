class AddRevRatingToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :review_rating, :integer
  end
end
