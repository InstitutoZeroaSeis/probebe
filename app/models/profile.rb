class Profile < ActiveRecord::Base

  belongs_to :user
  has_one :personal_profile
  has_one :mother_profile
  has_one :contact_profile

  validates_presence_of :user
end
