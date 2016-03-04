class CreateSiteMenus < ActiveRecord::Migration
  def change
    create_table :site_menus do |t|
      t.string :name
      t.integer :position
      t.integer :parent_menu_id
      t.boolean :target_blank
      t.string :link

      t.timestamps
    end
  end
end
