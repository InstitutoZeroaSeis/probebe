class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  include Carnival::ModelHelper
  include RejectAttributesConcern
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :confirmable

  ROLE_ENUM = [:admin, :journalist, :author]
  ALL_ROLES = ROLE_ENUM + [:site_user]

  scope :admin_site_user, -> { where(role: [0, 1 ,2]) }

  enum role: ALL_ROLES

  has_one :profile

  accepts_nested_attributes_for :profile,allow_destroy: true, reject_if: all_blank?(:first_name, :last_name)

  before_save :set_defaults

  validates_presence_of :profile

  def password_required?
    false
  end

  def set_defaults
    self.role ||= :site_user
  end

  def has_profile?
    profile.present?
  end

  def has_no_profile?
    !has_profile?
  end

  def to_label
    name_or_email
  end

  def name_or_email
    profile.present? ? profile.name : email
  end

  def profile_id
    profile.id
  end
end
