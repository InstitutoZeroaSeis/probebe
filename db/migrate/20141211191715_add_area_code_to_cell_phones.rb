class AddAreaCodeToCellPhones < ActiveRecord::Migration
  def change
    add_column :cell_phones, :area_code, :string
  end
end
