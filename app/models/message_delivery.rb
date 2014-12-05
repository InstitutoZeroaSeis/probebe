class MessageDelivery < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include Carnival::ModelHelper

  belongs_to :message
  belongs_to :profile
  after_create :send_message


  def article
    message.messageable
  end

  def profile_name
    profile.name
  end

  def send_message
    unless self.message_for_test
      send_message_to_device
    end
  end

  def send_message_to_device
    if profile.device_registration.nil?
      # SpringWsdl.send_message(self.profile.cell_phones.first.number, self.message.text)
    else
      n = Rpush::Gcm::Notification.new
      n.app = Rpush::Gcm::App.find_by(name: "pro-bebe-android")
      n.registration_ids = [profile.device_registration.platform_code]
      n.data = { message: message.text, article_url: post_url(message.article)  }
      n.save!
    end
  end
end
