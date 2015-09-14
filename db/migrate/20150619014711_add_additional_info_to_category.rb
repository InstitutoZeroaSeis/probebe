class AddAdditionalInfoToCategory < ActiveRecord::Migration
  def up
    add_column :categories, :slug, :string
    add_column :categories, :title, :string
    add_column :categories, :subtitle, :string
    add_column :categories, :text, :text
    add_column :categories, :category_image_text, :text
    add_column :categories, :show_in_home, :boolean
  end

  def down
    remove_column :categories, :slug, :string
    remove_column :categories, :title, :string
    remove_column :categories, :subtitle, :string
    remove_column :categories, :text, :text
    remove_column :categories, :category_image_text, :text
    remove_column :categories, :show_in_home, :boolean
  end
end
