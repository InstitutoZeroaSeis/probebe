module MessageDeliveries
  class MessageSender

    def initialize(message_delivery)
      @message_delivery = message_delivery
    end

    def send_to_device
      if @message_delivery.device_registrations.empty?
        deliver_through_sms
      else
        deliver_through_app
      end
    end

    protected

    def deliver_through_sms
      if ProBebeConfig.deliver_sms?
        MessageDeliveries::SpringWsdl.send_message(@message_delivery.cell_phone_number, @message_delivery.text, @message_delivery.id)
      else
        true
      end
    end

    def deliver_through_app
      n = Rpush::Gcm::Notification.new
      n.app = Rpush::Gcm::App.find_by(name: "pro-bebe-android")
      n.registration_ids = @message_delivery.device_registrations.map(&:platform_code)
      n.data = { message: @message_delivery.text }
      n.save
    end

  end
end
