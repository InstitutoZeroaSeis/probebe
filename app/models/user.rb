class User < ActiveRecord::Base
  include Carnival::ModelHelper
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :omniauthable

  ROLE_ENUM = [:admin, :journalist, :author]
  ALL_ROLES = ROLE_ENUM + [:site_user]

  has_one :profile

  validates :password, presence: true, on: :sign_up
  validates :profile, presence: true

  accepts_nested_attributes_for :profile

  before_save :set_defaults

  scope :admin_site_user, -> { where(role: [0, 1, 2]) }

  enum role: ALL_ROLES

  delegate :id, :name, :city, :state, :street, :birth_date,
           :primary_cell_phone_number, to: :profile, prefix: true

  def password_required?
    false
  end

  def set_defaults
    self.role ||= :site_user
  end

  alias_attribute :to_label, :name
end
