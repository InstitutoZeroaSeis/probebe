module Articles
  class Article < ActiveRecord::Base
    include Carnival::ModelHelper
    include RejectAttributesConcern

    GENDER_ENUM = [:male, :female, :both]
    BABY_TARGET_TYPE_ENUM = [:pregnancy, :born]
    CHILD_LIFE_PERIOD_ENUM = [:first_to_fourth, :fifth_to_eighth,
                              :nineth_to_twelfth, :thirteenth_to_eighteenth]

    default_scope { order(created_at: :desc) }

    enum baby_target_type: BABY_TARGET_TYPE_ENUM
    enum child_life_period: CHILD_LIFE_PERIOD_ENUM
    enum gender: GENDER_ENUM


    belongs_to :cover_picture, class_name: 'Ckeditor::Asset'
    belongs_to :thumb_picture, class_name: 'Ckeditor::Asset'
    belongs_to :category
    belongs_to :original_author, class_name: 'Authors::Author'
    belongs_to :user
    has_and_belongs_to_many :tags
    has_many :article_references
    has_many :messages

    accepts_nested_attributes_for :messages, reject_if: all_blank?(:text), allow_destroy: true
    accepts_nested_attributes_for :article_references, allow_destroy: true
    accepts_nested_attributes_for :tags, allow_destroy: false

    validates :text, :title, :category, :user, :original_author,
              :baby_target_type, :gender, presence: true

    validate :minimum_not_higher_than_maximum
    validate :presence_of_maximum_or_minimum
    validate :category_is_a_subcategory
    validate :length_of_messages

    before_validation :ensure_presence_of_original_author
    before_save :set_defaults
    before_save :update_child_life_period
    after_save :update_messages

    delegate :name, to: :category, prefix: true
    delegate :name, to: :original_author, prefix: true

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

    def tag_names
      tags.map(&:name).join(', ')
    end

    def tag_names=(tag_names)
      split_tag_names = Articles::TagSplitter.new(tag_names).split_by_comma
      self.tags =
        Articles::TagByNameCreator.new(split_tag_names)
        .find_or_create_tags
    end

    def thumb_image_cover
      return self.thumb_picture.data if self.thumb_picture.present?
    end

    def cover
      return self.cover_picture.data if self.cover_picture.present?
    end

    protected

    def category_is_a_subcategory
      return if category.try(:subcategory?)
      errors.add(:category, :should_be_subcategory)
    end

    def update_messages
      Articles::MessageUpdater.update_many_from_article(messages, self)
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

    def ensure_presence_of_original_author
      self.original_author ||= Authors::DefaultAuthor.find_default_author
    end
  end
end
