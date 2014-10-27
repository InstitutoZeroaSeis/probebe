class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :number
      t.integer :type
      t.integer :personal_profile_id

      t.timestamps
    end
  end
end
