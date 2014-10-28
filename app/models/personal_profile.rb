class PersonalProfile < ActiveRecord::Base
  GENDER_ENUM = [:male, :female, :not_informed]

  belongs_to :profile
  has_one :avatar

  enum gender: GENDER_ENUM

  validates_presence_of :first_name, :last_name

  before_save :set_defaults

  accepts_nested_attributes_for :avatar

  def name
    "#{first_name} #{last_name}"
  end

  def avatar_url
    avatar.photo.url if avatar
  end

  protected

  def set_defaults
    self.gender ||= 'not_informed'
  end

end
