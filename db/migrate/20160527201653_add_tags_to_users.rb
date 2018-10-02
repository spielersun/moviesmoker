class AddTagsToUsers < ActiveRecord::Migration
    def change
        add_column :users, :fav_tags, :string
    end
end
