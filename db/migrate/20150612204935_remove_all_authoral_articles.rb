class RemoveAllAuthoralArticles < ActiveRecord::Migration
  class Article < ActiveRecord::Base

  end
  def up
    Article.delete_all(type: 'Articles::AuthorialArticle')
  end

  def down

  end
end
