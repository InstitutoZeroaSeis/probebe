class MotherProfile < ActiveRecord::Base
  belongs_to :profile
  has_many :children

  validates_acceptance_of :is_mother, unless: -> { is_mother? or is_pregnant? }
  validates_acceptance_of :is_pregnant, unless: -> { is_mother? or is_pregnant? }
  validates_presence_of :profile

  accepts_nested_attributes_for :children, allow_destroy: true
end
