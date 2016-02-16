class AddMenuReferenceToPage < ActiveRecord::Migration
  def change
    add_column :site_pages, :menu_id, :integer
  end
end
