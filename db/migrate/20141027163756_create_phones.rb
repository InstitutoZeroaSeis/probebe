class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :number
      t.integer :phone_type, default: 0
      t.string :area_code
      t.references :profile

      t.timestamps
    end
  end
end
