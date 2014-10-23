class Message < ActiveRecord::Base
  include Carnival::ModelHelper

  # enum gender: { male: 0, female: 1, both: 2 }

  validates_presence_of :title, :text, :gender

end
