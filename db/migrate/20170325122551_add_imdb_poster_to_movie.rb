class AddImdbPosterToMovie < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :imdb_poster, :string
  end
end
