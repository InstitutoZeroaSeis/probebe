class PersonalProfile < ActiveRecord::Base
  GENDER_ENUM = [:male, :female]

  belongs_to :profile
  has_one :avatar

  enum gender: GENDER_ENUM

  validates_presence_of :first_name, :last_name

  def name
    "#{first_name} #{last_name}"
  end

  def avatar_url
    avatar.photo.url if avatar
  end
end
