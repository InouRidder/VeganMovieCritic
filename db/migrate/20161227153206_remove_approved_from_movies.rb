class RemoveApprovedFromMovies < ActiveRecord::Migration[5.0]
  def change
    remove_column :movies, :approved, :boolean
  end
end
