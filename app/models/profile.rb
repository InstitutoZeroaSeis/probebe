class Profile < ActiveRecord::Base
  include Carnival::ModelHelper
  include RejectAttributesConcern

  DAYS_IN_WEEK = 7
  GENDER_ENUM = [:male, :female, :not_informed]
  CELL_PHONE_SYSTEM_ENUM = [:ios, :android, :other]
  PROFILE_TYPE_ENUM = [:recipient, :possible_donor , :donor]

  enum gender: GENDER_ENUM
  enum cell_phone_system: CELL_PHONE_SYSTEM_ENUM
  enum profile_type: PROFILE_TYPE_ENUM

  serialize :message_days

  belongs_to :user
  has_many :donations_children, class_name: 'Child', foreign_key: :donor_id
  has_many :children
  has_many(
    :device_registrations, class_name: 'MessageDeliveries::DeviceRegistration'
  )
  has_one :avatar
  has_many :donated_messages

  validates :name, presence: true
  validates :cell_phone, presence: true, on: [:update], if: :site_user?
  validates :cell_phone, format: {
    with: /\A\d{2}\s\d{4,5}\-\d{4,4}\Z/
  }, on: [:update], if: :site_user?
  validate :mobile_phone?, on: [:update], if: :site_user?
  validate :validate_profile_type, if: "!donations_children.empty?"

  accepts_nested_attributes_for :avatar
  accepts_nested_attributes_for(
    :children, allow_destroy: true, reject_if: all_blank?(:name, :birth_date)
  )

  before_save :set_defaults
  before_save :manage_donor_children

  scope :admin_site_user_profiles, lambda {
    joins(:user).merge(User.admin_site_user)
  }
  scope :completed, -> {
    where.not(cell_phone: nil).
    joins(:children)
  }

  alias_attribute :primary_cell_phone_number, :cell_phone

  def authorize_receive_sms!
    self.authorized_receive_sms = true
    self.profile_type = Profile.profile_types[:possible_donor] if self.recipient?
    Users::SmsMessageSender.send_authorize_receive_sms_msg self.user
    save!
  end

  def unauthorize_receive_sms!
    self.authorized_receive_sms = false
    if self.device_registrations.empty? && self.possible_donor?
      self.profile_type = Profile.profile_types[:recipient]
    end
    save!
  end

  def profile_completed_message_sent!
    self.profile_completed_message_sent = true
    save!
  end

  def allow_sms_message_sent!
    self.allow_sms_message_sent = true
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

  def cell_phone_numbers
    self.cell_phone.gsub(/([^\d])+/, '')
  end

  protected

  def set_defaults
    self.gender ||= 'not_informed'
  end

  def manage_donor_children
    if self.donor? || self.possible_donor?
      self.children.update_all(donor_id: nil)
    end
  end

  def site_user?
    user.present? && user.site_user?
  end

  def mobile_phone?
    return if self.cell_phone.nil?
    return if !self.cell_phone_changed?
    return if errors.get(:cell_phone).present?
    return if TeleinService.mobile_phone? self.cell_phone_numbers
    errors.add(:cell_phone, :not_mobile_phone)
  end

  def validate_profile_type
    return if self.donor?
    errors.add(:base, :needs_to_be_donor)
  end

end
