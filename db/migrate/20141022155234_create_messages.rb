class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.integer :gender, default: 2
      t.integer :category_id
      t.boolean :teenage_pregnancy

      t.timestamps
    end
  end
end
