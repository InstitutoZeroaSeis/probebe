class MoveDataFromCellPhonesToProfile < ActiveRecord::Migration
  def change
    execute <<-SQL
      update profiles
      set profiles.cell_phone =
      (select concat(cell_phones.area_code, ' ', cell_phones.number) from cell_phones where cell_phones.id = profiles.id)
    SQL
  end
end
