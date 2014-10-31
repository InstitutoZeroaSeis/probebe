class Profile < ActiveRecord::Base

  belongs_to :user
  has_one :personal_profile
  has_one :mother_profile
  has_one :contact_profile
  has_and_belongs_to_many :message_delivery

  validates_presence_of :user
end
