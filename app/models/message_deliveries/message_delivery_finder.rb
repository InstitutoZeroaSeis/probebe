module MessageDeliveries
  class MessageDeliveryFinder
    def self.find_and_deliver_messages(managerMessage_id)
      managerMessage = ManagerMessageDeliveries.find(managerMessage_id)
      start_manager_message(managerMessage)
      MessageDelivery.created_today.not_sent.each do |message_delivery|
        send_message message_delivery
      end
      end_manager_message(managerMessage)
    end

    def self.send_message(message_delivery)
      begin
        Rails.logger.info "[SendMessage] Start Send Message, id: #{message_delivery.id}, status: #{message_delivery.status}"
        sender = MessageSender.new(message_delivery)
        sent = sender.send_to_device
        if sent
          Rails.logger.info "[SendMessage] Message Sent, id: #{message_delivery.id}, status: #{message_delivery.status}"
          message_delivery.sent!
        else
          Rails.logger.info "[SendMessage] Message not Sent, id: #{message_delivery.id}, status: #{message_delivery.status}"
        end
      rescue => e
        Rails.logger.info "Erron on MessageSender, message_delivery.id: #{message_delivery.id} #{e}"
      end
    end

    def self.start_manager_message(managerMessage)
      managerMessage.update(messages_sent_start: Time.now)
    end

    def self.end_manager_message(managerMessage)
      message_delivery = MessageDelivery.created_today
      managerMessage.update(
        messages_sent_end: Time.now,
        sum_messages_sent: message_delivery.sent.size,
        sum_messages_sent_by_sms: message_delivery.sent.where(sms_allowed: true).size,
        sum_messages_sent_by_android: sum_cell_phone_system_from(message_delivery, 1),
        sum_messages_sent_by_ios: sum_cell_phone_system_from(message_delivery, 0))
    end

    def self.sum_cell_phone_system_from(message_delivery, system)
      message_delivery.by_cell_phone_system(system).size
    end

  end
end
