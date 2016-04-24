class Child < ActiveRecord::Base
  DAYS_IN_WEEK = 7
  PREGNANCY_DURATION_IN_WEEKS = 42
  MAX_AGE_IN_WEEKS = 72
  GENDER_ENUM = [:male, :female, :not_informed]

  belongs_to :profile
  belongs_to :donor, class_name: 'Profile'
  has_many :message_deliveries, class_name: "MessageDeliveries::MessageDelivery"
  has_one :avatar
  enum gender: GENDER_ENUM

  validates_presence_of :birth_date
  validate :maximum_permited_pregnancy_date?
  validate :minimum_birth_date?
  validate :miximum_birth_date?
  validate :recipient_profile?, if: "donor.present?"

  before_save :set_defaults

  delegate :primary_cell_phone_number, to: :profile
  delegate :device_registrations, to: :profile
  delegate :authorized_receive_sms, to: :profile

  scope :completed_profile, -> {
    eager_load(:profile)
    .where.not('profiles.cell_phone' => nil)
  }

  scope :actived_profile, -> {
    eager_load(:profile)
    .where('profiles.active' => true)
  }

  scope :not_recipient, ->{
    eager_load(:profile)
    .where.not(profiles: { profile_type: Profile.profile_types[:recipient] })
  }

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

  def valid_age_in_weeks?
    age_in_weeks <= MAX_AGE_IN_WEEKS
  end

  def pregnancy_start_date(system_date = nil)
    system_date ||= MessageDeliveries::SystemDate.new
    birth_date - PREGNANCY_DURATION_IN_WEEKS.weeks if pregnancy?(system_date)
  end

  def category_ids
    message_deliveries.joins(message: :category).pluck(:category_id)
  end

  def attributes
    {
      id: nil,
      name: @name,
      age_in_weeks: self.age_in_weeks,
      birth_date: @birth_date,
      gender: @gender
    }
  end

  def self.recipients(profiles_with_priority)
    eager_load(:profile).
    where(donor: nil).
    where(profiles: { profile_type: Profile.profile_types[:recipient] }).
    where(profiles: {id: profiles_with_priority})
  end

  def self.was_recipient(limit)
    where.not(was_recipient_until: nil).
    limit(limit)
  end

  def self.was_not_recipient(limit)
    where(was_recipient_until: nil).
    limit(limit)
  end

  protected

  def maximum_permited_pregnancy_date?
    if birth_date.present?
      if birth_date > PREGNANCY_DURATION_IN_WEEKS.weeks.from_now
        errors.add(:birth_date, I18n.t('activerecord.errors.models.child.base.maximum_permited_pregnancy_date'))
      end
    end
  end

  def minimum_birth_date?
    return if birth_date.nil?
    if birth_date < (DateTime.now - 5.years)
      errors.add(:birth_date, I18n.t('activerecord.errors.models.child.base.minimum_birth_date'))
    end
  end

  def miximum_birth_date?
    return if birth_date.nil?
    unless valid_age_in_weeks?
      errors.add(:birth_date, I18n.t('activerecord.errors.models.child.base.miximum_birth_date'))
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
