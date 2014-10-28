class Message < ActiveRecord::Base
  include Carnival::ModelHelper

  GENDER_ENUM = [:male, :female, :both]
  BABY_TARGET_TYPE_ENUM = [:pregnancy, :born]

  enum gender: GENDER_ENUM
  enum baby_target_type: BABY_TARGET_TYPE_ENUM

  belongs_to :category

  validates_presence_of :text, :gender, :category, :baby_target_type

  before_save :set_defaults

  def set_defaults
    self.baby_target_type ||= 'pregnancy'
  end

end
