class MessageDelivery < ActiveRecord::Base
  belongs_to :message
  belongs_to :profile

  def article
    message.messageable
  end
end
