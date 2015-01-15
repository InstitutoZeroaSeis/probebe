class Profile < ActiveRecord::Base
  include Carnival::ModelHelper

  DAYS_IN_WEEK = 7
  GENDER_ENUM = [:male, :female, :not_informed]

  enum gender: GENDER_ENUM

  belongs_to :user
  has_many :children
  has_many :cell_phones
  has_many :device_registrations, class_name: "MessageDeliveries::DeviceRegistration"
  has_one :avatar

  validates_presence_of :first_name, :last_name, :user

  accepts_nested_attributes_for :avatar
  accepts_nested_attributes_for :children, allow_destroy: true, reject_if: proc { |child| (child[:name].blank? and child[:birth_date].blank?) }
  accepts_nested_attributes_for :cell_phones, allow_destroy: true, reject_if: proc { |cell_phone| (cell_phone[:area_code].blank? and cell_phone[:number].blank?) }

  before_save :set_defaults
  before_save :update_name

  scope :admin_site_user_profiles, -> { joins(:user).merge(User.admin_site_user) }

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

  def primary_cell_phone_number
    cell_phones.first.full_number unless cell_phones.empty?
  end

  protected

  def set_defaults
    self.gender ||= 'not_informed'
  end

  def update_name
    self.name = "#{first_name} #{last_name}"
  end
end
