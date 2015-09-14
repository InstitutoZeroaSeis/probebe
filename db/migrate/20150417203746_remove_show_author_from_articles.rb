class RemoveShowAuthorFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :show_author, :boolean
  end
end
