module MessageDeliveries
  class MessageDeliveryFinder
    def self.find_and_deliver_messages
      MessageDelivery.created_today.not_sent.each do |message_delivery|
        send_message message_delivery
      end
    end

    def self.send_message(message_delivery)
      begin
        sender = MessageSender.new(message_delivery)
        sent = sender.send_to_device
        if sent
          message_delivery.sent!
        end
      rescue
        Rails.logger.debug "Erron on MessageSender, message_delivery.id: #{message_delivery.id}"
      end
    end
  end
end
