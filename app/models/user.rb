class User < ActiveRecord::Base
  include Carnival::ModelHelper
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :omniauthable

  ROLE_ENUM = [:admin, :publisher]
  ALL_ROLES = ROLE_ENUM + [:site_user]

  has_one :profile

  validates :profile, presence: true

  accepts_nested_attributes_for :profile

  before_save :set_defaults
  before_save :set_search_column

  scope :admin_site_user, -> { where(role: [0, 1, 2]) }
  scope :completed_profile, -> {
      eager_load(profile: [:children, :device_registrations]).
      where('profiles.cell_phone IS NOT NULL').
      where('length(profiles.cell_phone) > 1').
      where('children.profile_id IS NOT NULL').
      distinct
  }

  enum role: ALL_ROLES

  delegate :id, :name, to: :profile, prefix: true

  alias_attribute :to_label, :name

  def password_required?
    true
  end

  def set_defaults
    self.role ||= :site_user
  end

  def set_search_column
    self.search_column = " #{email} #{profile.name} #{profile.cell_phone}"
  end

  def self.with_device
    completed_profile
    .where("device_registrations.profile_id IS NOT NULL")
    .where("profiles.active = true")
    .distinct
  end

  def self.with_device_android
    completed_profile
    .with_device
    .where('profiles.cell_phone_system = 1 OR profiles.cell_phone_system = 2')
    .where("profiles.active = true")
  end

  def self.with_device_ios
    completed_profile
    .with_device
    .where('profiles.cell_phone_system = 0')
    .where("profiles.active = true")
  end

  def self.unauthorized_receive_sms
    completed_profile
    .where('profiles.authorized_receive_sms = ?', false)
    .where("device_registrations.profile_id IS NULL")
    .where("profiles.active = true")
    .distinct
  end

  def self.authorized_receive_sms
    completed_profile
    .where('profiles.authorized_receive_sms = ?', true)
    .where("device_registrations.profile_id IS NULL")
    .where("profiles.active = true")
    .distinct
  end

  def self.disabled
    eager_load(:profile)
    .where("profiles.active = false")
  end

  def self.donor
    eager_load(:profile)
    .where("profiles.profile_type = 2")
  end

end
