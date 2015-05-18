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
  before_validation :ensure_presence_of_original_author

  delegate :profile, to: :original_author

  def category_name
    category.name
  end

  def original_author_name
    original_author.profile_name
  end

  def update_messages
    Articles::MessageUpdater.update_many_from_article(messages, self)
  end

  def tag_names
    tags.map(&:name).join(', ')
  end

  def tag_names=(tag_names)
    split_tag_names = Articles::TagSplitter.new(tag_names).split_by_comma
    self.tags =
      Articles::TagByNameCreator.new(split_tag_names)
      .find_or_create_tags
  end

  private

  def ensure_presence_of_original_author
    self.original_author ||= Authors::DefaultAuthor.find_default_author
  end

  def length_of_messages
    return unless messages.find { |message| message.text_size > 150 }
    errors.add(:base, :messages_length)
  end

  def update_child_life_period
    return unless born?
    self.child_life_period = Children::LifePeriodForWeek
      .new(minimum_valid_week, maximum_valid_week).life_period
  end
end
