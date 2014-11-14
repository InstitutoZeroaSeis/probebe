class MessageDelivery < ActiveRecord::Base
  belongs_to :message
  has_and_belongs_to_many :profiles

  def article
    message.messageable
  end
end
