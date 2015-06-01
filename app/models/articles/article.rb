module Articles
  class Article < ActiveRecord::Base
    include Carnival::ModelHelper

    GENDER_ENUM = [:male, :female, :both]
    BABY_TARGET_TYPE_ENUM = [:pregnancy, :born]
    CHILD_LIFE_PERIOD_ENUM = [:first_to_fourth, :fifth_to_eighth,
                              :nineth_to_twelfth, :thirteenth_to_eighteenth]

    default_scope { order(created_at: :desc) }

    enum baby_target_type: BABY_TARGET_TYPE_ENUM
    enum child_life_period: CHILD_LIFE_PERIOD_ENUM
    enum gender: GENDER_ENUM

    belongs_to :category
    belongs_to :original_author, class_name: 'Authors::Author'
    belongs_to :user
    has_and_belongs_to_many :tags
    has_many :article_references

    accepts_nested_attributes_for :article_references, allow_destroy: true
    accepts_nested_attributes_for :tags, allow_destroy: false

    validates :text, :title, :category, :user, :type,
              :baby_target_type, :gender, presence: true

    validate :minimum_not_higher_than_maximum
    validate :presence_of_maximum_or_minimum
    validate :category_is_a_subcategory

    before_save :set_defaults

    scope :journalistic, -> { where(type: 'Articles::JournalisticArticle') }

    has_paper_trail

    def presence_of_maximum_or_minimum
      return unless minimum_valid_week.blank? && maximum_valid_week.blank?
      errors.add(:base, :has_no_minimum_and_maximum_valid_week)
    end

    def minimum_not_higher_than_maximum
      return unless minimum_valid_week.present? && maximum_valid_week.present?
      return unless minimum_valid_week > maximum_valid_week
      errors.add(:base, :minimum_higher_than_maximum)
    end

    def set_defaults
      self.baby_target_type ||= 'pregnancy'
    end

    def born?
      baby_target_type == 'born'
    end

    def pregnancy?
      !born?
    end

    protected

    def category_is_a_subcategory
      return if category.try(:subcategory?)
      errors.add(:category, :should_be_subcategory)
    end
  end
end
