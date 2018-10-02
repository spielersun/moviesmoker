class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.string :year
      t.string :imdb
      t.text :genres

      t.timestamps null: false
    end
  end
end
