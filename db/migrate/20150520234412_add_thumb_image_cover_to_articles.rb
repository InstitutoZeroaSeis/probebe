class AddThumbImageCoverToArticles < ActiveRecord::Migration
  def change
    add_attachment :articles, :thumb_image_cover
  end
end
