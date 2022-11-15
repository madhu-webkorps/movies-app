class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :name
      t.integer :year
      t.string :director
      t.string :main_star
      t.text :discription
      t.integer :favourite ,default: 0
     
      t.timestamps
    end
  end
end
