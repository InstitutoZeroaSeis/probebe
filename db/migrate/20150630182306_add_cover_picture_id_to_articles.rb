class AddCoverPictureIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :cover_picture_id, :integer
    add_index :articles, :cover_picture_id
  end
end
