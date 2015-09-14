class CreateSiteLandingPages < ActiveRecord::Migration
  def change
    create_table :site_landing_pages do |t|
      t.string :title
      t.text :text
      t.integer :picture_id, index: true
      t.timestamps
    end
  end
end
