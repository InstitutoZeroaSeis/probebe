class Message < ActiveRecord::Base
  include Carnival::ModelHelper

  belongs_to :messageable, polymorphic: true
  has_many :message_deliveries

  validates_presence_of :text

  def message_already_sent_for_profile(profile)
    profile.message_deliveries.none? do |delivery|
      self == delivery.message
    end
  end

end
