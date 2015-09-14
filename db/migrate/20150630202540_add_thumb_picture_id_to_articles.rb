class AddThumbPictureIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :thumb_picture_id, :integer
    add_index :articles, :thumb_picture_id
  end
end
