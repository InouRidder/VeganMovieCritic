class RemoveUserRatingReview < ActiveRecord::Migration[5.0]
  def change
    remove_column :reviews, :user_rating, :integer
  end
end
