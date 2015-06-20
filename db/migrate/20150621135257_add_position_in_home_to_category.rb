class AddPositionInHomeToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :position_in_home, :integer
  end
end
