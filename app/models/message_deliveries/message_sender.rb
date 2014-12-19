module MessageDeliveries
  class MessageSender
    def initialize(profile, message)
      @profile = profile
      @message = message
    end

    def send_to_device
      if @profile.device_registrations.empty?
        deliver_through_sms
      else
        deliver_through_app
      end
    end

    protected

    def deliver_through_sms
      if ProBebeConfig.deliver_sms?
        MessageDeliveries::SpringWsdl.send_message(@profile.cell_phones.first.full_number, @message.text)
      else
        true
      end
    end

    def deliver_through_app(*args)
      n = Rpush::Gcm::Notification.new
      n.app = Rpush::Gcm::App.find_by(name: "pro-bebe-android")
      n.registration_ids = @profile.device_registrations.map(&:platform_code)
      n.data = { message: @message.text }
      n.save
    end
  end
end
