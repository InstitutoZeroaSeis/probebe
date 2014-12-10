class Child < ActiveRecord::Base
  DAYS_IN_WEEK = 7
  PREGNANCY_DURATION_IN_WEEKS = 42
  GENDER_ENUM = [:male, :female]

  belongs_to :profile
  has_many :message_deliveries, class_name: "MessageDeliveries::MessageDelivery"

  enum gender: GENDER_ENUM

  delegate :device_registration, to: :profile

  validates_presence_of :birth_date

  def age_in_weeks system_date = nil
    system_date ||= MessageDeliveries::SystemDate.new
    if pregnancy?(system_date)
      (system_date.date - pregnancy_start_date(system_date)).to_i / DAYS_IN_WEEK
    else
      (system_date.date - birth_date.to_date).to_i / DAYS_IN_WEEK
    end
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
end
