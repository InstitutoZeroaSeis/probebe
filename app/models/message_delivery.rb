class MessageDelivery < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to :message
  belongs_to :profile
  after_create :send_message_to_device


  def article
    message.messageable
  end

  def send_message_to_device
    if profile.device_registration.nil?
      SpringWsdl.send_message(self.profile.cell_phones.first.number, self.message.text)
    else
      n = Rpush::Gcm::Notification.new
      n.app = Rpush::Gcm::App.find_by(name: "pro-bebe-android")
      n.registration_ids = [profile.device_registration.platform_code]
      n.data = { message: message.text, article_url: post_url(article, host: '192.168.1.43', port: 3000) }
      n.save!
    end
  end
end
