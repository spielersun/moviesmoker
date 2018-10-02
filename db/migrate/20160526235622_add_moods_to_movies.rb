class AddMoodsToMovies < ActiveRecord::Migration
    def change
        add_column :movies, :mood_fast, :integer, default: 50
        add_column :movies, :mood_imaginary, :integer, default: 50
        add_column :movies, :mood_colored, :integer, default: 50
        add_column :movies, :mood_comedy, :integer, default: 50
        add_column :movies, :mood_intelligent, :integer, default: 50
        add_column :movies, :mood_ambient, :integer, default: 50
        add_column :movies, :mood_diverse, :integer, default: 50
        add_column :movies, :mood_wibbly, :integer, default: 50
        add_column :movies, :mood_talky, :integer, default: 50
        add_column :movies, :mood_known, :integer, default: 50
        add_column :movies, :mood_characteristic, :integer, default: 50
        add_column :movies, :env_group, :integer, default: 0
        add_column :movies, :env_theater, :integer, default: 0
        add_column :movies, :env_consume, :integer, default: 0
        add_column :movies, :personal_age, :integer, default:27
        add_column :movies, :personal_gender, :integer, default:50
    end
end
