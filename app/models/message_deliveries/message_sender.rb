module MessageDeliveries
  class MessageSender
    def initialize(profile, message)
      @profile = profile
      @message = message
    end

    def send_to_device
      if @profile.device_registration.nil?
        SpringWsdl.send_message(@profile.cell_phones.first.number, @message.text)
      else
        n = Rpush::Gcm::Notification.new
        n.app = Rpush::Gcm::App.find_by(name: "pro-bebe-android")
        n.registration_ids = [@profile.device_registration.platform_code]
        n.data = { message: @message.text }
        n.save
      end
    end
  end
end
