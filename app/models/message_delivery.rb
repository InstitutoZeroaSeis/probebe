class MessageDelivery < ActiveRecord::Base
  belongs_to :message
  belongs_to :profile
  after_create :send_message_to_devise


  def article
    message.messageable
  end

  def send_message_to_devise
    SpringWsdl.send_message(self.profile.cell_phones.first.number, self.message.text)
  end
end
