class RemoveParentCategoryFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :parent_category, :string
  end
end
