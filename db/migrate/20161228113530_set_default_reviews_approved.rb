class SetDefaultReviewsApproved < ActiveRecord::Migration[5.0]
  def change
    change_column :reviews, :approved, :boolean, :default => false
  end
end
