class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :name
      t.text :text
      t.integer :logo_id, index: true
      t.integer :picture_id, index: true
      t.timestamps
    end
  end
end
