class AddApprovedToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :approved, :boolean
  end
end
