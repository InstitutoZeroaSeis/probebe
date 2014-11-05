class Articles::JournalisticArticle < Articles::Article
  
  belongs_to :parent_article, class_name: "Articles::AuthorialArticle", foreign_key: :parent_article_id
  validates_presence_of :parent_article
  
end