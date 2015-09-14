class AddShowAuthorToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :show_author, :boolean, default: true
  end
end
