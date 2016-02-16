class AddSlugColumnToPage < ActiveRecord::Migration
  def change
    add_column :site_pages, :slug, :string
  end
end
