class AddFavsToUsers < ActiveRecord::Migration
    def change
        add_column :users, :fav_mood_fast, :integer, default: 50
        add_column :users, :fav_mood_imaginary, :integer, default: 50
        add_column :users, :fav_mood_colored, :integer, default: 50
        add_column :users, :fav_mood_comedy, :integer, default: 50
        add_column :users, :fav_mood_intelligent, :integer, default: 50
        add_column :users, :fav_mood_ambient, :integer, default: 50
        add_column :users, :fav_mood_diverse, :integer, default: 50
        add_column :users, :fav_mood_wibbly, :integer, default: 50
        add_column :users, :fav_mood_talky, :integer, default: 50
        add_column :users, :fav_mood_known, :integer, default: 50
        add_column :users, :fav_mood_characteristic, :integer, default: 50
        add_column :users, :fav_env_group, :integer, default: 0
        add_column :users, :fav_env_theater, :integer, default: 0
        add_column :users, :fav_env_consume, :integer, default: 0
        add_column :users, :birthdate, :datetime
        add_column :users, :gender, :boolean, default:true
    end
end