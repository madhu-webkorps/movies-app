class Addcolumntomovies < ActiveRecord::Migration[6.1]
  def change
    add_reference :movies, :genre, index: true
    add_foreign_key :movies, :genres
  end
end
