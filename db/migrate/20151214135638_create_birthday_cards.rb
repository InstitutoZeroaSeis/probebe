class CreateBirthdayCards < ActiveRecord::Migration
  def change
    create_table :birthday_cards do |t|
      t.integer :age
      t.text :text
      t.attachment :avatar

      t.timestamps
    end
  end
end
