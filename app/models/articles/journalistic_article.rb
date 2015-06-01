class Articles::JournalisticArticle < Articles::Article
  include Carnival::ModelHelper
  include RejectAttributesConcern

  belongs_to :parent_article,
             class_name: 'Articles::AuthorialArticle',
             foreign_key: :parent_article_id,
             counter_cache: true,
             touch: true

  has_attached_file :cover,
                    path: 'articles/journalistic_articles/:attachment/:id_partition/:style/:filename',
                    styles: { content: '1920>', thumb: '118x100#' }
  has_attached_file :thumb_image_cover,
                    path: 'articles/journalistic_articles/:attachment/:id_partition/:style/:filename',
                    styles: { content: '300x200', thumb: '118x100#' }

  has_many :messages,
           -> { where(messageable_type: 'Articles::JournalisticArticle') },
           foreign_key: 'messageable_id'

  accepts_nested_attributes_for :messages, reject_if: all_blank?(:text)

  validates :parent_article, presence: true
  validates :original_author, presence: true
  validate :length_of_messages

  validates_attachment_content_type :cover, content_type: /\Aimage/
  validates_attachment_content_type :thumb_image_cover, content_type: /\Aimage/

  after_save :update_messages
  before_save :update_child_life_period
  before_validation :ensure_presence_of_original_author

  delegate :name, to: :category, prefix: true
  delegate :name, to: :original_author, prefix: true

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
