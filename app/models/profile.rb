class Profile < ActiveRecord::Base
  DAYS_IN_WEEK = 7
  GENDER_ENUM = [:male, :female, :not_informed]

  enum gender: GENDER_ENUM

  belongs_to :user
  has_and_belongs_to_many :message_deliveries
  has_many :children
  has_many :cell_phones
  has_one :avatar

  validate :has_children, on: :update
  validate :has_cell_phone, on: :update
  validates_presence_of :birth_date, on: :update
  validates_presence_of :first_name, :last_name, :user

  accepts_nested_attributes_for :avatar
  accepts_nested_attributes_for :children, allow_destroy: true
  accepts_nested_attributes_for :cell_phones, allow_destroy: true

  before_save :set_defaults

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

  def pregnancy_start_date
    child = children.find {|c| c.pregnancy? }
    child.pregnancy_start_date if child
  end

  protected

  def set_defaults
    self.gender ||= 'not_informed'
  end

  def has_cell_phone
    if cell_phones.empty?
      errors.add(:base, I18n.t('activerecord.errors.models.profile.base.needs_mobile_phone'))
    end
  end

  def has_children
    current_children = children.select {|c| !c.marked_for_destruction? }
    if current_children.empty?
      errors.add(:base, I18n.t('activerecord.errors.models.profile.base.has_no_children'))
    end
  end

end
