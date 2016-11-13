class AddTitleToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :title, :string
  end
end
