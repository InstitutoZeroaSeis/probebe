class Message < ActiveRecord::Base
  include Carnival::ModelHelper

  belongs_to :messageable, polymorphic: true
  has_many :message_deliveries

  validates_presence_of :text



  def age_valid_for_message?(age_in_weeks)
    min_week = minimum_valid_week || 0
    max_week = maximum_valid_week || Message::MAXIMUM_POSSIBLE_WEEK
    (min_week..max_week).include? age_in_weeks
  end
end
