class Child < ActiveRecord::Base
  DAYS_IN_WEEK = 7
  WEEKS_IN_YEAR = 42
  GENDER_ENUM = [:male, :female]

  enum gender: GENDER_ENUM

  validates_presence_of :name, :birth_date, :gender, if: :born?
  validates_presence_of :pregnancy_start_date, unless: :born?

  def age_in_weeks
    if self.born?
      age_for_born
    else
      age_in_pregnancy
    end
  end

  protected

  def age_for_born
    (Date.today - birth_date.to_date).to_i / DAYS_IN_WEEK
  end

  def age_in_pregnancy
    (Date.today - pregnancy_start_date.to_date).to_i / DAYS_IN_WEEK
  end
end
