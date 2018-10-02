class CreateBnndlsts < ActiveRecord::Migration
  def change
    create_table :bnndlsts do |t|
      t.references :user, index: true, foreign_key: true
      t.references :movie, index: true, foreign_key: true
      t.datetime :add_time

      t.timestamps null: false
    end
  end
end
