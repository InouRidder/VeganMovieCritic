class CreateReviewRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :review_ratings do |t|
      t.integer :rating
      t.timestamps
    end
  end
end
