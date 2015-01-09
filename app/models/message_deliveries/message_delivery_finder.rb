module MessageDeliveries
  class MessageDeliveryFinder
    def find_and_deliver_messages
      MessageDelivery.created_today.not_sent.each do |message_delivery|
        sender = MessageSender.new(message_delivery)
        sent = sender.send_to_device
        if sent
          message_delivery.sent!
        end
      end
    end
  end
end
