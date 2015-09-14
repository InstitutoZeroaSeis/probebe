class AddDefaultGenderValueToChild < ActiveRecord::Migration
  def change
    change_column :children, :gender, :integer, default: 2
  end
end
