class AddInfoToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :info, :string
    add_column :profiles, :country, :string
  end
end
