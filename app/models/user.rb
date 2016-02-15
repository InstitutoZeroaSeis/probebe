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

  scope :admin_site_user, -> { where(role: [0, 1, 2]) }
  scope :completed_profile, -> {
      joins(profile: [:children]).
      where('profiles.cell_phone is not NULL').
      where('length(profiles.cell_phone) > 1').
      distinct
  }
  scope :authorized_receive_sms, -> { completed_profile.where('profiles.authorized_receive_sms = ?', true) }
  scope :unauthorized_receive_sms, -> { completed_profile.where('profiles.authorized_receive_sms = ?', false) }

  enum role: ALL_ROLES

  delegate :id, :name, to: :profile, prefix: true

  def password_required?
    true
  end

  def set_defaults
    self.role ||= :site_user
  end

  alias_attribute :to_label, :name

  def self.with_device
    joins("LEFT JOIN profiles on profiles.user_id = users.id LEFT JOIN device_registrations ON profiles.id = device_registrations.profile_id")
    .where("device_registrations.profile_id IS NOT NULL")
  end

end
