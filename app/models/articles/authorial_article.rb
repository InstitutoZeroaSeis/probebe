class Articles::AuthorialArticle < Articles::Article
  include Carnival::ModelHelper

  after_update :update_related_journalistic_articles

  has_many :messages, as: :messageable do
    def build(*args, &block)
      item = super(*args, &block)
      item.messageable_type = "Articles::AuthorialArticle"
      item
    end
  end

  has_many :journalistic_articles, class_name: "Articles::JournalisticArticle", foreign_key: :parent_article_id

  accepts_nested_attributes_for :messages, reject_if: proc { |attributes| attributes['text'].blank? }

  def update_related_journalistic_articles
    Articles::JournalisticArticleUpdater.update_journalistic_from_authorial_article(self)
  end
end
