class AddAttachmentBackgroundImageToSiteBanners < ActiveRecord::Migration
  def self.up
    change_table :site_banners do |t|
      t.attachment :background_image
    end
  end

  def self.down
    remove_attachment :site_banners, :background_image
  end
end
