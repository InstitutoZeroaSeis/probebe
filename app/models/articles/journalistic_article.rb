class Articles::JournalisticArticle < Articles::Article
  include Carnival::ModelHelper

  belongs_to :parent_article, class_name: "Articles::AuthorialArticle", foreign_key: :parent_article_id, counter_cache: true, touch: true
  has_many :messages, as: :messageable do
    def build(*args, &block)
      item = super(*args, &block)
      item.messageable_type = "Articles::JournalisticArticle"
      item
    end
  end

  accepts_nested_attributes_for :messages, reject_if: proc { |attributes| attributes['text'].blank? }
  validates_presence_of :parent_article, :original_author
  validate :length_of_messages

  after_save :update_messages

  def update_messages
    Articles::MessageUpdater.update_many_from_article(messages, self)
  end

  def category_name
    category.name
  end

  def parent_article_text
    parent_article.text
  end

  private

  def length_of_messages
    messages.each do |message|
      if message.text.size > 150
        errors.add(:base, I18n.t('activerecord.errors.models.articles/journalistic_article.base.messages_length'))
      end
    end
  end
end
