class CreateSiteCoordinatorsPages < ActiveRecord::Migration
  def change
    create_table :site_coordinators_pages do |t|
      t.string :title
      t.text :text
      t.integer :picture_id

      t.timestamps
    end
  end
end
