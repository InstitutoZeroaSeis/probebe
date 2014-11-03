class Message < ActiveRecord::Base
  include Carnival::ModelHelper

  MAXIMUM_POSSIBLE_WEEK = 5200
  GENDER_ENUM = [:male, :female, :both]
  BABY_TARGET_TYPE_ENUM = [:pregnancy, :born]

  enum gender: GENDER_ENUM
  enum baby_target_type: BABY_TARGET_TYPE_ENUM

  belongs_to :category
  has_many :message_deliveries

  validates_presence_of :text, :gender, :category, :baby_target_type
  validate :presence_of_maximum_or_minimum
  validate :minimum_not_higher_than_maximum

  before_save :set_defaults

  def set_defaults
    self.baby_target_type ||= 'pregnancy'
  end

  def presence_of_maximum_or_minimum
    if (self.minimum_valid_week.blank? && self.maximum_valid_week.blank?)
      errors.add(:base, I18n.t('activerecord.errors.models.message.base.has_no_minimum_and_maximum_valid_week'))
    end
  end

  def minimum_not_higher_than_maximum
    if self.minimum_valid_week.present? and self.maximum_valid_week.present?
      if minimum_valid_week > maximum_valid_week
        errors.add(:base, I18n.t('activerecord.errors.models.message.base.minimum_higher_than_maximum'))
      end
    end
  end

  def age_valid_for_message?(age_in_weeks)
    min_week = minimum_valid_week || 0
    max_week = maximum_valid_week || Message::MAXIMUM_POSSIBLE_WEEK
    (min_week..max_week).include? age_in_weeks
  end
end
