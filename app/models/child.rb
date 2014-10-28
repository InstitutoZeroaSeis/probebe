class Child < ActiveRecord::Base
  GENDER_ENUM = [:male, :female]

  belongs_to :mother_profile

  enum gender: GENDER_ENUM

  validates_presence_of :name, :birth_date, :gender
end
