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

  delegate :id, :name, :city, :state, :street, :birth_date, :primary_cell_phone_number, to: :profile, prefix: true

  def password_required?
    false
  end

  def set_defaults
    self.role ||= :site_user
  end

  alias_attribute :to_label, :name

end
