class Authors::Author < ActiveRecord::Base
  include Carnival::ModelHelper

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "50x50>", :small  => "150x150>" }, default_url: "/images/:style/missing.png"

  validates_attachment_content_type :photo, content_type: /\Aimage/

  validates :name, presence: true
  validates :bio, presence: true

  delegate :url, to: :photo, prefix: true
  before_destroy :check_for_articles

  has_many :articles, foreign_key: "original_author_id", class_name: 'Articles::Article'

  def check_for_articles
    if articles.count > 0
      errors.add(:articles, I18n.t("errors.models.articles.base.has_articles"))
      return false
    end
  end
end
