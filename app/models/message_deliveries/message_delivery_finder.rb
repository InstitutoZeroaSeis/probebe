module MessageDeliveries
  class MessageDeliveryFinder
    def self.find_and_deliver_messages
      MessageDelivery.created_today.not_sent.each do |message_delivery|
        send_message message_delivery
      end
    end

    def self.send_message(message_delivery)
      begin
        Rails.logger.debug "[SendMessage] Start Send Message, id: #{message_delivery.id}, status: #{message_delivery.status}"
        sender = MessageSender.new(message_delivery)
        sent = sender.send_to_device
        if sent
          Rails.logger.debug "[SendMessage] Message Sent, id: #{message_delivery.id}, status: #{message_delivery.status}"
          message_delivery.sent!
        else
          Rails.logger.debug "[SendMessage] Message not Sent, id: #{message_delivery.id}, status: #{message_delivery.status}"
        end
      rescue
        Rails.logger.debug "Erron on MessageSender, message_delivery.id: #{message_delivery.id}"
      end
    end
  end
end
