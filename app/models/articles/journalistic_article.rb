class Articles::JournalisticArticle < Articles::Article
  include Carnival::ModelHelper
  
  belongs_to :parent_article, class_name: "Articles::AuthorialArticle", foreign_key: :parent_article_id
  has_many :message, as: :messageable
  
  validates_presence_of :parent_article
  
end