class Articles::AuthorialArticle < Articles::Article
  has_many :sub_articles, class_name: "Articles::JournalisticArticle", foreign_key: :parent_article_id

end