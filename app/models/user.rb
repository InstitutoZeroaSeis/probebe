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
  scope :authorized_receive_sms, -> { joins(:profile).merge(Profile.where(authorized_receive_sms: true)) }
  scope :unauthorized_receive_sms, -> { joins(:profile).merge(Profile.where(authorized_receive_sms: false)) }

  enum role: ALL_ROLES

  delegate :id, :name, to: :profile, prefix: true

  def password_required?
    true
  end

  def set_defaults
    self.role ||= :site_user
  end

  alias_attribute :to_label, :name
end
