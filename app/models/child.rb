class Child < ActiveRecord::Base
  DAYS_IN_WEEK = 7
  PREGNANCY_DURATION_IN_WEEKS = 42
  GENDER_ENUM = [:male, :female, :not_informed]

  belongs_to :profile
  belongs_to :donor, class_name: 'Profile'
  has_many :message_deliveries, class_name: "MessageDeliveries::MessageDelivery"
  has_one :avatar
  enum gender: GENDER_ENUM

  validates_presence_of :birth_date
  validate :maximum_permited_pregnancy_date?
  validate :recipient_profile?, if: "donor.present?"

  before_save :set_defaults

  delegate :primary_cell_phone_number, to: :profile
  delegate :device_registrations, to: :profile
  delegate :authorized_receive_sms, to: :profile

  def age_in_weeks system_date = nil
    system_date ||= MessageDeliveries::SystemDate.new
    if pregnancy?(system_date)
      (system_date.date - pregnancy_start_date(system_date)).to_i / DAYS_IN_WEEK
    else
      (system_date.date - birth_date.to_date).to_i / DAYS_IN_WEEK
    end
  end

  def avatar_url
    avatar.photo.url(:thumb) if avatar
  end

  def pregnancy? system_date = nil
    system_date ||= MessageDeliveries::SystemDate.new
    birth_date > system_date.date
  end

  def born? system_date = nil
    system_date ||= MessageDeliveries::SystemDate.new
    !pregnancy?(system_date)
  end

  def pregnancy_start_date(system_date = nil)
    system_date ||= MessageDeliveries::SystemDate.new
    birth_date - PREGNANCY_DURATION_IN_WEEKS.weeks if pregnancy?(system_date)
  end

  def category_ids
    message_deliveries.joins(message: :category).pluck(:category_id)
  end

  protected

  def maximum_permited_pregnancy_date?
    if birth_date.present?
      if birth_date > PREGNANCY_DURATION_IN_WEEKS.weeks.from_now
        errors.add(:birth_date, I18n.t('activerecord.errors.models.child.base.maximum_permited_pregnancy_date'))
      end
    end
  end

  def recipient_profile?
    return if profile.recipient?
    errors.add(:donor, :profile_donor)
  end

  def set_defaults
    self.gender ||= 'not_informed'
  end
end
