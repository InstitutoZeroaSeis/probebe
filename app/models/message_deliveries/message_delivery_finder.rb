module MessageDeliveries
  class MessageDeliveryFinder
    def self.find_and_deliver_messages(message_delivery)
      send_message message_delivery
    end

    def self.send_message(message_delivery)
      begin
        Rails.logger.info "[SendMessage] Start Send Message, id: #{message_delivery.id}, status: #{message_delivery.status}"
        sender = MessageSender.new(message_delivery)
        sent = sender.send_to_device
        if sent
          Rails.logger.info "[SendMessage] Message Sent, id: #{message_delivery.id}, status: #{message_delivery.status}"
          message_delivery.sent!
          update_manager_message(message_delivery)
        else
          Rails.logger.info "[SendMessage] Message not Sent, id: #{message_delivery.id}, status: #{message_delivery.status}"
        end
      rescue => e
        Rails.logger.info "Erron on MessageSender, message_delivery.id: #{message_delivery.id} #{e}"
      end
    end

    def self.update_manager_message(message_delivery)
      manager_message = MessageDeliveries::ManagerMessageDeliveries.lock.last
      manager_message.counter_increase(message_delivery)
      manager_message.save!
    end

  end
end
