class CreateTitleVotes < ActiveRecord::Migration
  def change
    create_table :title_votes do |t|
      t.string :commenter
      t.integer :vote
      t.references :movie, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
