class CreateReviewRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :review_ratings do |t|
      t.integer :rating
      t.references :user
      t.references :review

      t.timestamps
    end
  end
end
