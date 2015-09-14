class ChangeMessageableToArticleInMessages < ActiveRecord::Migration
  def change
    rename_column :messages, :messageable_id, :article_id
    remove_column :messages, :messageable_type, :string, default: 'Articles::JournalisticArticle'
  end
end
