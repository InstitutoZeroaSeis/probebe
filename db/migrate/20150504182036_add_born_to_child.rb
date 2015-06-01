class AddBornToChild < ActiveRecord::Migration
  def change
    add_column :children, :born, :boolean, default: false
  end
end
