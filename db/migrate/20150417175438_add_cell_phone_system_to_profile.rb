class AddCellPhoneSystemToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :cell_phone_system, :integer, default: 2
  end
end
