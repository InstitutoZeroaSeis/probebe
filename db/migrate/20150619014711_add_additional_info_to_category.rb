class AddAdditionalInfoToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :slug, :string
    add_column :categories, :title, :string
    add_column :categories, :subtitle, :string
    add_column :categories, :text, :text
    add_column :categories, :category_image_text, :text
    add_column :categories, :show_in_home, :boolean
    add_column :categories, :color, :string
  end
end
