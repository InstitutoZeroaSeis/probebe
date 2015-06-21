class AddPositionInHomeToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :position_in_home, :integer
    add_column :categories, :second_color, :string
  end
end
