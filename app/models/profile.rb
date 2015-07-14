class Profile < ActiveRecord::Base
  include Carnival::ModelHelper
  include RejectAttributesConcern

  DAYS_IN_WEEK = 7
  GENDER_ENUM = [:male, :female, :not_informed]
  CELL_PHONE_SYSTEM_ENUM = [:ios, :android, :other]

  enum gender: GENDER_ENUM
  enum cell_phone_system: CELL_PHONE_SYSTEM_ENUM

  belongs_to :user
  has_many :children
  has_many(
    :device_registrations, class_name: 'MessageDeliveries::DeviceRegistration'
  )
  has_one :avatar

  validates :name, :cell_phone, presence: true
  validates :cell_phone, format: {
    with: /\A\d{2}\s\d{4,5}\-\d{4,4}\Z/
  }

  accepts_nested_attributes_for :avatar
  accepts_nested_attributes_for(
    :children, allow_destroy: true, reject_if: all_blank?(:name, :birth_date)
  )

  before_save :set_defaults

  scope :admin_site_user_profiles, lambda {
    joins(:user).merge(User.admin_site_user)
  }

  alias_attribute :primary_cell_phone_number, :cell_phone

  def authorize_receive_sms!
    self.authorized_receive_sms = true
    save!
  end

  def unauthorize_receive_sms!
    self.authorized_receive_sms = false
    save!
  end

  def avatar_url
    avatar.photo.url(:thumb) if avatar
  end

  def update_avatar_from_url(url)
    self.avatar ||=
      Avatar.create_from_url(url, profile: self)
  end

  def pregnancy_start_date
    child = children.find(&:pregnancy?)
    child.pregnancy_start_date if child
  end

  protected

  def set_defaults
    self.gender ||= 'not_informed'
  end
end
