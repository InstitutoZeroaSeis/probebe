module Articles
  class Article < ActiveRecord::Base
    include Carnival::ModelHelper

    MAXIMUM_POSSIBLE_WEEK = 5200
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

    validates_presence_of :text, :title, :category, :user, :type, :baby_target_type, :gender

    validate :presence_of_maximum_or_minimum
    validate :minimum_not_higher_than_maximum

    before_save :set_defaults


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
  end
end
