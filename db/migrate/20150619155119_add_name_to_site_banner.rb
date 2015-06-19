class AddNameToSiteBanner < ActiveRecord::Migration
  def change
    add_column :site_banners, :name, :string
    rename_column :site_banners, :banner_type, :position
  end
end
