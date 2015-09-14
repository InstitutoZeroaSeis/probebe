class AddCkeditorPictureToSiteBanner < ActiveRecord::Migration
  def change
    add_column :site_banners, :picture_id, :integer
    add_index :site_banners, :picture_id
  end
end
