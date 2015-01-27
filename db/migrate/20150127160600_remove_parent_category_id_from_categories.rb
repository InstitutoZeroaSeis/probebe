class RemoveParentCategoryIdFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :parent_category_id, :integer
  end
end
