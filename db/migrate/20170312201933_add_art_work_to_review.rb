class AddArtWorkToReview < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :artwork, :string
  end
end
