class AddCoverToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :cover_image, :string
  end
end
