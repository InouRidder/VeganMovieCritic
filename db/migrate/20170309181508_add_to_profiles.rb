class AddToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :username, :string
    add_column :profiles, :first_name, :string
    add_column :profiles, :last_name, :string
    add_reference :profiles, :user, foreign_key: true
  end
end
