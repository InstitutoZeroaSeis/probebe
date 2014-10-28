class MotherProfile < ActiveRecord::Base
  belongs_to :profile
  has_many :children

  validates_acceptance_of :is_mother, unless: -> { is_mother? or is_pregnant? }
  validates_acceptance_of :is_pregnant, unless: -> { is_mother? or is_pregnant? }
  validates_presence_of :profile
  validate :has_children

  accepts_nested_attributes_for :children, allow_destroy: true

  def has_children
    current_children = children.select {|c| !c.marked_for_destruction? }
    unless current_children.size > 0
      errors.add(:base, I18n.t('activerecord.errors.models.mother_profile.mother_has_no_children'))
    end
  end
end
