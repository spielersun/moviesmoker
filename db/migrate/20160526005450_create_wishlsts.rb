class CreateWishlsts < ActiveRecord::Migration
  def change
    create_table :wishlsts do |t|
      t.references :user, index: true, foreign_key: true
      t.references :movie, index: true, foreign_key: true
      t.datetime :add_date

      t.timestamps null: false
    end
  end
end
