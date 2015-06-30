class MigrateArticlesImagesToCkEditorPicture < ActiveRecord::Migration
  def up
    Articles::Article.all.each do |article|
      migrate_cover article
      migrate_thumb article
    end
  end

  def down

  end

  def migrate_cover(article)
    return false if article.cover_file_name.nil?
    table = Ckeditor::ArticleCoverImage.arel_table
    insert_manager = Arel::InsertManager.new(ActiveRecord::Base)
    insert_manager.insert(
      [
        [table[:data_file_name], article.cover_file_name],
        [table[:data_content_type], article.cover_content_type],
        [table[:data_file_size], article.cover_file_size],
        [table[:type], 'Ckeditor::ArticleCoverImage'],
        [table[:old_id], article.id]
      ]
    )

    ActiveRecord::Base.connection.execute insert_manager.to_sql

    article.cover_picture = Ckeditor::ArticleCoverImage.last
    article.save
  end

  def migrate_thumb(article)
    return false if article.thumb_image_cover_file_name.nil?
    table = Ckeditor::ArticleThumbImage.arel_table
    insert_manager = Arel::InsertManager.new(ActiveRecord::Base)
    insert_manager.insert(
      [
        [table[:data_file_name], article.thumb_image_cover_file_name],
        [table[:data_content_type], article.thumb_image_cover_content_type],
        [table[:data_file_size], article.thumb_image_cover_file_size],
        [table[:type], 'Ckeditor::ArticleThumbImage'],
        [table[:old_id], article.id]
      ]
    )

    ActiveRecord::Base.connection.execute insert_manager.to_sql

    article.thumb_picture = Ckeditor::ArticleThumbImage.last
    article.save
  end
end
