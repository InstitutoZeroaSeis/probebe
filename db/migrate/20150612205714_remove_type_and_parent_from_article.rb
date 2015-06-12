class RemoveTypeAndParentFromArticle < ActiveRecord::Migration
  def change
    remove_column :articles, :type, :string, default: 'Articles::JournalisticArticle'
    remove_column :articles, :parent_article_id, :integer
  end
end
