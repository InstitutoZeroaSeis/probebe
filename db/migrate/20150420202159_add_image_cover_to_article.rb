class AddImageCoverToArticle < ActiveRecord::Migration
  def change
    add_attachment :articles, :image_cover
  end
end
