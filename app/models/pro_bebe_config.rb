class ProBebeConfig
  def self.deliver_sms?
    Rails.configuration.message_delivery.deliver_sms
  end
end
