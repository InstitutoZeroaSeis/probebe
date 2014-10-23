class Message < ActiveRecord::Base
  include Carnival::ModelHelper

  belongs_to :category

  # enum gender: { male: 0, female: 1, both: 2 }

  validates_presence_of :text, :gender

end
