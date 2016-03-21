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
      joins(profile: [:children]).
      where('profiles.cell_phone is not NULL').
      where('length(profiles.cell_phone) > 1').
      distinct
  }
  # scope :authorized_receive_sms, -> { completed_profile.where('profiles.authorized_receive_sms = ?', true) }
  # scope :unauthorized_receive_sms, -> { completed_profile.where('profiles.authorized_receive_sms = ?', false) }

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
    joins("LEFT JOIN profiles as p on p.user_id = users.id LEFT JOIN device_registrations ON p.id = device_registrations.profile_id")
    .where("device_registrations.profile_id IS NOT NULL")
  end

  def self.unauthorized_receive_sms
    eager_load(profile: [:children, :device_registrations])
    .where('children.profile_id IS NOT NULL')
    .where('profiles.authorized_receive_sms = ?', false)
    .where('profiles.cell_phone is not NULL')
    .where('length(profiles.cell_phone) > 1')
    .where("device_registrations.profile_id IS NULL")
    .distinct
  end

  def self.authorized_receive_sms
    eager_load(:profile)
    .where('profiles.authorized_receive_sms = ?', true)
    .where('profiles.cell_phone is not NULL')
    .where('length(profiles.cell_phone) > 1')
    .distinct
  end

end
