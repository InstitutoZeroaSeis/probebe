class CreateInstitutePages < ActiveRecord::Migration
  def change
    create_table :institute_pages do |t|
      t.string :title
      t.text :text
      t.integer :picture_id, index: true

      t.timestamps
    end
  end
end
