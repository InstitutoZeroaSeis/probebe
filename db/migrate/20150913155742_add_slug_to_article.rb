class AddSlugToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :slug, :boolean
    add_index :articles, :slug, unique: true
  end
end
