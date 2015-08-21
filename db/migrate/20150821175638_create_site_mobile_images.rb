class CreateSiteMobileImages < ActiveRecord::Migration
  def change
    create_table :site_mobile_images do |t|
      t.string :name
      t.string :title
      t.text :text
      t.integer :picture_id, index: true
      t.timestamps
    end
  end
end
