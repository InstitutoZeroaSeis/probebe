class Message < ActiveRecord::Base
  include Carnival::ModelHelper

  GENDER_ENUM = [:male, :female, :both]
  BABY_TARGET_TYPE_ENUM = [:pregnancy, :born]

  enum gender: GENDER_ENUM
  enum baby_target_type: BABY_TARGET_TYPE_ENUM

  belongs_to :category

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
    if self.maximum_valid_week.present?
      errors.add(:base, I18n.t('activerecord.errors.models.message.base.minimum_higher_than_maximum')) if minimum_valid_week > maximum_valid_week
    end
  end

end
