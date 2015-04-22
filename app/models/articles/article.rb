module Articles
  class Article < ActiveRecord::Base
    include Carnival::ModelHelper

    GENDER_ENUM = [:male, :female, :both]
    BABY_TARGET_TYPE_ENUM = [:pregnancy, :born]

    enum gender: GENDER_ENUM
    enum baby_target_type: BABY_TARGET_TYPE_ENUM

    belongs_to :category
    belongs_to :user
    belongs_to :original_author, class_name: "User"
    has_many :article_references
    has_and_belongs_to_many :tags

    accepts_nested_attributes_for :article_references, allow_destroy: true
    accepts_nested_attributes_for :tags, allow_destroy: false

    validates_presence_of :text, :title, :category, :user, :type, :baby_target_type, :gender

    validate :presence_of_maximum_or_minimum
    validate :minimum_not_higher_than_maximum

    before_save :set_defaults

    scope :journalistic, -> { where(type: 'Articles::JournalisticArticle') }

    has_paper_trail

    def presence_of_maximum_or_minimum
      if (self.minimum_valid_week.blank? && self.maximum_valid_week.blank?)
        errors.add(:base, I18n.t('activerecord.errors.models.article.base.has_no_minimum_and_maximum_valid_week'))
      end
    end

    def minimum_not_higher_than_maximum
      if self.minimum_valid_week.present? and self.maximum_valid_week.present?
        if minimum_valid_week > maximum_valid_week
          errors.add(:base, I18n.t('activerecord.errors.models.article.base.minimum_higher_than_maximum'))
        end
      end
    end

    def set_defaults
      self.baby_target_type ||= 'pregnancy'
    end

    def self.match_title(search_term)
      arel_table[:title].matches("%#{search_term}%")
    end

    def self.match_text(search_term)
      arel_table[:text].matches("%#{search_term}%")
    end

    def born?
      baby_target_type == 'born'
    end

    def pregnancy?
      !born?
    end
  end
end
