class CreateSiteHeaders < ActiveRecord::Migration
  def change
    create_table :site_headers do |t|
      t.string :path
      t.integer :picture_id, index: true
      t.timestamps
    end
  end
end
