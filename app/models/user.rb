class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :confirmable

  has_one :profile
  has_one :personal_profile, through: :profile
  has_one :contact_profile, through: :profile

  validates_presence_of :email

  def password_required?
    false
  end
end
