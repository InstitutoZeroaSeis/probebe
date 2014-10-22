class Profile < ActiveRecord::Base
  belongs_to :user
  has_one :personal_profile

  validates_presence_of :user
end
