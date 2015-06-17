class CreateSiteBanners < ActiveRecord::Migration
  def change
    create_table :site_banners do |t|
      t.integer :banner_type
      t.string :title
      t.text :text
      t.timestamps
    end
  end
end
