class DropTableCellPhones < ActiveRecord::Migration
  def change
    drop_table :cell_phones
  end
end
