class AddLikeToReview < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :likes, :integer
  end
end
