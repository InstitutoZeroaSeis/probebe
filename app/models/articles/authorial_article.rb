class Articles::AuthorialArticle < Articles::Article
  include Carnival::ModelHelper
  include RejectAttributesConcern

  after_update :update_related_journalistic_articles

  has_many :messages,
           -> { where(messageable_type: 'Articles::AuthorialArticle') },
           foreign_key: 'messageable_id'

  has_many :journalistic_articles,
           class_name: 'Articles::JournalisticArticle',
           foreign_key: :parent_article_id

  after_save :update_messages
  accepts_nested_attributes_for :messages, reject_if: all_blank?(:text)

  def update_related_journalistic_articles
    Articles::JournalisticArticleUpdater
      .new(self)
      .update_all!
  end
end
