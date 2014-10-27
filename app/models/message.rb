class Message < ActiveRecord::Base
  include Carnival::ModelHelper

  GENDER_ENUM = [:male, :female, :both]
  enum gender: GENDER_ENUM

  belongs_to :category

  validates_presence_of :text, :gender, :category

end
