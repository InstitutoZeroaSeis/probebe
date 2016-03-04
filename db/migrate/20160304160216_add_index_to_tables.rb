class AddIndexToTables < ActiveRecord::Migration
  def change
    add_index :articles, :category_id
  end
end
