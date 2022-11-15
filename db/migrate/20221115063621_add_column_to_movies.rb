class AddColumnToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :favorited, :boolean , default: :false
    add_column :movies, :fav_count, :integer , default: 0
    # add_column :movies, :fav_count, :integer , default: 0

  end
end
