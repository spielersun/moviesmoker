class CreateWatcheds < ActiveRecord::Migration
  def change
    create_table :watcheds do |t|
      t.integer :movie_id
      t.integer :user_id
      t.datetime :add_date

      t.timestamps null: false
    end
  end
end
