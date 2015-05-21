class AddCoverToArticles < ActiveRecord::Migration
  class Article < ActiveRecord::Base
  end

  def change
    add_attachment :articles, :cover

    Article.find_in_batches(batch_size: 50) do |batch|
      batch.each do |article|
        next if article.image_cover.blank?
        article.update_attributes(cover: open(article.image_cover))
      end
    end
  end
end
