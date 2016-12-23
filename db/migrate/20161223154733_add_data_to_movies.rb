class AddDataToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :released, :string
    add_column :movies, :runtime, :string
    add_column :movies, :genre, :string
    add_column :movies, :plot, :string
    add_column :movies, :actors, :string
    add_column :movies, :awards, :string
    add_column :movies, :poster, :string
    add_column :movies, :imdbrating, :string
  end
end
