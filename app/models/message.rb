class Message < ActiveRecord::Base
  include Carnival::ModelHelper

  belongs_to :category
  belongs_to :messageable, polymorphic: true
  has_many :message_deliveries

  enum gender: [:male, :female, :both]
  enum baby_target_type: [:pregnancy, :born]

  validates_presence_of :text

  def message_already_sent_for_profile(profile)
    profile.message_deliveries.none? do |delivery|
      self == delivery.message
    end
  end

end
