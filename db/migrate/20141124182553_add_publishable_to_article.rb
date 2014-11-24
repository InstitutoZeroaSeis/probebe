class AddPublishableToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :publishable, :boolean, default: false
  end
end
