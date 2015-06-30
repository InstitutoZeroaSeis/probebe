class AddPictureIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :picture_id, :integer
    add_index :categories, :picture_id
  end
end
