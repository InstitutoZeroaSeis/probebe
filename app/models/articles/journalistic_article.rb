class Articles::JournalisticArticle < Articles::Article
  include Carnival::ModelHelper
  include RejectAttributesConcern

  belongs_to :parent_article,
             class_name: 'Articles::AuthorialArticle',
             foreign_key: :parent_article_id,
             counter_cache: true,
             touch: true

  has_many :messages,
           -> { where(messageable_type: 'Articles::JournalisticArticle') },
           foreign_key: 'messageable_id'

  accepts_nested_attributes_for :messages, reject_if: all_blank?(:text)

  validates :parent_article, presence: true
  validates :original_author, presence: true
  validate :length_of_messages

  after_save :update_messages
  before_save :update_child_life_period
  before_validation :verify_original_author

  delegate :profile, to: :original_author

  def update_messages
    Articles::MessageUpdater.update_many_from_article(messages, self)
  end

  def category_name
    I18n.t("_parent_category.#{category.parent_category_type}")
  end

  def original_author_name
    original_author.profile_name
  end

  private

  def update_child_life_period
    return unless born?
    self.child_life_period = Children::LifePeriodForWeek
      .new(minimum_valid_week, maximum_valid_week).life_period
  end

  def verify_original_author
    self.original_author ||= Author::DefaultAuthor.find_default_author
  end

  def length_of_messages
    messages.each do |message|
      if message.text.size > 150
        errors.add(:base,
          I18n.t('activerecord.errors.models.articles/journalistic_article.base.messages_length'))
      end
    end
  end
end
