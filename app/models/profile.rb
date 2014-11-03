class Profile < ActiveRecord::Base
  DAYS_IN_WEEK = 7
  GENDER_ENUM = [:male, :female, :not_informed]

  enum gender: GENDER_ENUM

  belongs_to :user
  has_and_belongs_to_many :message_deliveries
  has_many :children
  has_many :phones
  has_one :avatar

  validate :has_children, on: :update, if: :is_mother?
  validate :has_dumbphone_or_smartphone, on: :update
  validate :is_mother_or_pregnant, on: :update
  validates_presence_of :birth_date, on: :update
  validates_presence_of :first_name, :last_name, :user
  validates_presence_of :pregnancy_start_date, if: :is_pregnant?

  accepts_nested_attributes_for :avatar
  accepts_nested_attributes_for :children, allow_destroy: true
  accepts_nested_attributes_for :phones, allow_destroy: true

  before_save :set_defaults

  scope :mother, -> { where(is_mother: true) }
  scope :pregnant, -> { where(is_pregnant: true) }

  def name
    "#{first_name} #{last_name}"
  end

  def avatar_url
    avatar.photo.url if avatar
  end

  def update_avatar_from_url(url)
    unless self.avatar
      self.avatar = Avatar.create_from_url(url, profile: self)
    end
  end

  def pregnancy_age_in_weeks
    (Date.today - pregnancy_start_date).to_i / DAYS_IN_WEEK
  end

  protected

  def set_defaults
    self.gender ||= 'not_informed'
  end

  def has_dumbphone_or_smartphone
    unless phones.any? {|p| ["dumbphone", "smartphone"].include? p.phone_type }
      errors.add(:base, I18n.t('activerecord.errors.models.profile.base.needs_some_mobile_phone'))
    end
  end

  def has_children
    current_children = children.select {|c| !c.marked_for_destruction? }
    unless current_children.size > 0
      errors.add(:base, I18n.t('activerecord.errors.models.profile.base.has_no_children'))
    end
  end

  def is_mother_or_pregnant
    unless is_mother? or is_pregnant?
      errors.add(:base, I18n.t('activerecord.errors.models.profile.base.needs_to_be_mother_or_pregnant'))
    end
  end

end
