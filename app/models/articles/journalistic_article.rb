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

end
