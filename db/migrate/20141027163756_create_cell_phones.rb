class CreateCellPhones < ActiveRecord::Migration
  def change
    create_table :cell_phones do |t|
      t.string :number
      t.references :profile

      t.timestamps
    end
  end
end
