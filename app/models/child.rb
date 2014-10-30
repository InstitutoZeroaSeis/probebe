class Child < ActiveRecord::Base
  DAYS_IN_WEEK = 7
  WEEKS_IN_YEAR = 42
  GENDER_ENUM = [:male, :female]

  belongs_to :mother_profile

  enum gender: GENDER_ENUM

  validates_presence_of :gender
  validates_presence_of :name, :birth_date, if: :born?
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
    expected_date = Date.commercial(expected_birth_year.to_i, expected_birth_week.to_i)
    start_date = expected_date - WEEKS_IN_YEAR.weeks
    (Date.today - start_date).to_i / DAYS_IN_WEEK
  end
end
