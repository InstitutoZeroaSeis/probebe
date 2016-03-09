module MessageDeliveries
  class MessageDeliveryFinder
    def self.find_and_deliver_messages(message_delivery)
      send_message(message_delivery)
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
      manager_message = MessageDeliveries::ManagerMessageDeliveries.last
      counter_increase(manager_message, message_delivery)
    end

    def self.counter_increase(manager_message, message_delivery)
      manager_message.with_lock do
        manager_message.messages_sent_end = message_delivery.updated_at
        manager_message.sum_messages_sent += 1
        case message_delivery.was_sent_through
           when 'sms' then manager_message.sum_messages_sent_by_sms += 1
           when "ios" then manager_message.sum_messages_sent_by_ios += 1
           when "android" then manager_message.sum_messages_sent_by_android += 1
           else manager_message.sum_messages_sent_by_android += 1
        end
        manager_message.save!
      end
    end

  end
end
