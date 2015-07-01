class MigrateSiteBannersBackgroundToCkeditorPicture < ActiveRecord::Migration
  def up
    SiteBanner.all.each do |banner|

      table = Ckeditor::SiteBannersImage.arel_table
      insert_manager = Arel::InsertManager.new(ActiveRecord::Base)
      insert_manager.insert(
        [
          [table[:data_file_name], banner.background_image_file_name],
          [table[:data_content_type], banner.background_image_content_type],
          [table[:data_file_size], banner.background_image_file_size],
          [table[:created_at], DateTime.now],
          [table[:type], 'Ckeditor::SiteBannersImage'],
          [table[:old_id], banner.id]
        ]
      )

      ActiveRecord::Base.connection.execute insert_manager.to_sql

      banner.picture = Ckeditor::SiteBannersImage.last
      banner.save

    end
  end

  def down

  end
end
