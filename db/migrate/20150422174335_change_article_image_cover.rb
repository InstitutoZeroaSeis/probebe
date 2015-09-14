class ChangeArticleImageCover < ActiveRecord::Migration
  def change
    remove_attachment :articles, :image_cover
    add_column :articles, :image_cover, :string
  end
end
