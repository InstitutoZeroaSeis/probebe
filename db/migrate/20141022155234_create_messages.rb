class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.integer :messageable_id
      t.string  :messageable_type

      t.timestamps
    end
  end
end
