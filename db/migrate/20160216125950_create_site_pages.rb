class CreateSitePages < ActiveRecord::Migration
  def change
    create_table :site_pages do |t|
      t.string :title
      t.string :subtitle
      t.text :text

      t.timestamps
    end
  end
end
