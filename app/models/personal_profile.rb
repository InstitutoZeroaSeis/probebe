class PersonalProfile < ActiveRecord::Base
  GENDER_ENUM = [:male, :female, :not_informed]

  belongs_to :profile
  has_one :avatar

  enum gender: GENDER_ENUM

  validates_presence_of :first_name, :last_name

  accepts_nested_attributes_for :avatar

  def name
    "#{first_name} #{last_name}"
  end

  def avatar_url
    avatar.photo.url if avatar
  end
end
