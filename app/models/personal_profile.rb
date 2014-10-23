class PersonalProfile < ActiveRecord::Base
  belongs_to :profile
  has_one :avatar

  validates_presence_of :profile
end
