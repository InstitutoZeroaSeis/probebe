class Child < ActiveRecord::Base
  DAYS_IN_WEEK = 7
  GENDER_ENUM = [:male, :female]

  enum gender: GENDER_ENUM

  validates_presence_of :name, :birth_date, :gender

  def age_in_weeks
    (Date.today - birth_date.to_date).to_i / DAYS_IN_WEEK
  end

end
