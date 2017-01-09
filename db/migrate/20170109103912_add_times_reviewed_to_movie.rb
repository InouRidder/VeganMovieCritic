class AddTimesReviewedToMovie < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :times_reviewed, :integer
  end
end
