class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  include Carnival::ModelHelper
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :confirmable

  ROLE_ENUM = [:admin, :site_user, :journalist, :author]

  enum role: ROLE_ENUM

  has_one :profile

  before_save :set_defaults

  validates_presence_of :email

  def password_required?
    false
  end

  def set_defaults
    self.role ||= :site_user
  end
end
