class Articles::AuthorialArticle < Articles::Article
  include Carnival::ModelHelper

  has_many :messages, as: :messageable do
    def build(*args, &block)
      item = super(*args, &block)
      item.messageable_type = "Articles::AuthorialArticle"
      item
    end
  end
  
  has_many :sub_articles, class_name: "Articles::JournalisticArticle", foreign_key: :parent_article_id

end
