class AddOldIdToCkeditorAsset < ActiveRecord::Migration
  def change
    add_column :ckeditor_assets, :old_id, :integer
  end
end
