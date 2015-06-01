class AddOriginalCategoryTypeToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :original_category_type, :integer
  end
end
