class ChangeReferenceBetweenMenuAndPage < ActiveRecord::Migration
  def change
    add_column :site_menus, :page_id, :integer
    remove_column :site_pages, :menu_id, :integer
  end
end
