class AddCountryAndLanguageToMovie < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :director, :string
    add_column :movies, :language, :string
  end
end
