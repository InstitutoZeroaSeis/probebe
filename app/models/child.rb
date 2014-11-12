class Child < ActiveRecord::Base
  DAYS_IN_WEEK = 7
  PREGNANCY_DURATION_IN_WEEKS = 42
  GENDER_ENUM = [:male, :female]

  enum gender: GENDER_ENUM

  validates_presence_of :birth_date

  def age_in_weeks
    if pregnancy?
      (Date.today - pregnancy_start_date).to_i / DAYS_IN_WEEK
    else
      (Date.today - birth_date.to_date).to_i / DAYS_IN_WEEK
    end
  end

  def pregnancy?
    birth_date.future?
  end

  def born?
    !pregnancy?
  end

  def pregnancy_start_date
    birth_date - PREGNANCY_DURATION_IN_WEEKS.weeks if pregnancy?
  end

end
