class Articles::JournalisticArticle < Articles::Article
  include Carnival::ModelHelper
  include RejectAttributesConcern

  belongs_to :parent_article, class_name: "Articles::AuthorialArticle", foreign_key: :parent_article_id, counter_cache: true, touch: true
  has_many :messages, as: :messageable do
    def build(*args, &block)
      item = super(*args, &block)
      item.messageable_type = "Articles::JournalisticArticle"
      item
    end
  end

  has_attached_file :image_cover, styles: { full: '640x480', thumb: '160x120'}
  validates_attachment_content_type :image_cover, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :image_cover, :in => 0..1.megabyte

  accepts_nested_attributes_for :messages, reject_if: all_blank?(:text)
  validates_presence_of :parent_article, :original_author, :image_cover
  validate :length_of_messages

  after_save :update_messages
  before_save :set_defaults

  def update_messages
    Articles::MessageUpdater.update_many_from_article(messages, self)
  end

  def category_name
    category.name
  end

  def parent_article_text
    parent_article.text
  end

  def original_author_name
    original_author.profile_name
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
