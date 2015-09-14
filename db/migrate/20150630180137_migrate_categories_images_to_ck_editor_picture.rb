class MigrateCategoriesImagesToCkEditorPicture < ActiveRecord::Migration
  def up
    Category.all.each do |category|
      next if category.category_image_file_name.nil?
      table = Ckeditor::CategoryImage.arel_table
      insert_manager = Arel::InsertManager.new(ActiveRecord::Base)
      insert_manager.insert(
        [
          [table[:data_file_name], category.category_image_file_name],
          [table[:data_content_type], category.category_image_content_type],
          [table[:data_file_size], category.category_image_file_size],
          [table[:type], 'Ckeditor::CategoryImage'],
          [table[:created_at], DateTime.now],
          [table[:old_id], category.id]
        ]
      )

      ActiveRecord::Base.connection.execute insert_manager.to_sql

      category.picture = Ckeditor::CategoryImage.last
      category.save

    end
  end

  def down

  end
end
