class AddUserRatingToReview < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :user_rating, :integer
  end
end
