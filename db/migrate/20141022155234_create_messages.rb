class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.integer :gender, default: 2
      t.integer :category_id
      t.boolean :teenage_pregnancy
      t.integer :baby_target_type
      t.integer :minimum_valid_week
      t.integer :maximum_valid_week

      t.timestamps
    end
  end
end
