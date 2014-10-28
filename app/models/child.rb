class Child < ActiveRecord::Base
  GENDER_ENUM = [:male, :female]

  belongs_to :mother_profile

  enum gender: GENDER_ENUM

  validates_presence_of :name, :gender
  validates_presence_of :birth_date, if: :born?
  validates_presence_of :expected_birth_week, :expected_birth_year, if: -> { !born? }

end
