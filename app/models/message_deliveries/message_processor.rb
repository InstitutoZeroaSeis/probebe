module MessageDeliveries
  class MessageProcessor
    attr_reader :child
    attr_reader :testing_mode

    def initialize(system_date, testing_mode = false)
      @system_date = system_date
      @testing_mode = testing_mode
    end

    def send_messages
      Child.all.each do |child|
        message = find_message_for_child(child)
        if message.present?
          delivery = build_message_delivery(child, message)
          # sent = send_to_device(delivery)
          # if sent
            delivery.save!
          # end
        end
      end
    end

    protected

    def build_message_delivery(child, message)
      MessageDelivery.new(
        message: message,
        child: child,
        delivery_date: @system_date.date,
        message_for_test: testing_mode
      )
    end

    def find_message_for_child(child)
      message_matcher = MessageDeliveries::MessageMatcher.new(messages_to_send, child, @system_date )
      messages = message_matcher.find_messages_for_child
      messages.first if messages.count > 0
    end

    def messages_to_send
      Message.journalistic
    end

    def send_to_device(delivery)
      # if delivery.child..device_registration.nil?
      #   SpringWsdl.send_message(self.profile.cell_phones.first.number, self.message.text)
      # else
      #   n = Rpush::Gcm::Notification.new
      #   n.app = Rpush::Gcm::App.find_by(name: "pro-bebe-android")
      #   n.registration_ids = [profile.device_registration.platform_code]
      #   n.data = { message: message.text }
      #   n.save
      # end
    end
  end
end
