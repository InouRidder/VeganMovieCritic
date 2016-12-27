class AddPendingToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :approved, :boolean
  end
end
