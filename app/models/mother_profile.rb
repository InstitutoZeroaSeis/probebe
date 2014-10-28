class MotherProfile < ActiveRecord::Base
  belongs_to :profile

  validates_acceptance_of :is_mother, unless: -> { is_mother? or is_pregnant? }
  validates_acceptance_of :is_pregnant, unless: -> { is_mother? or is_pregnant? }
  validates_presence_of :profile
end
