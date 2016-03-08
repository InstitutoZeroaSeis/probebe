class MessageDeliveries::ManagerMessageDeliveries < ActiveRecord::Base
  self.table_name = 'message_deliveries_manager_message_deliveries'

  #   def perform(managerMessage)
  #   managerMessage = MessageDeliveries::ManagerMessageDeliveries.last
  #   end_manager_message(managerMessage)
  # end

  # def self.end_manager_message(managerMessage)
  #   message_delivery = MessageDelivery.created_today
  #   managerMessage.update(
  #     sum_messages_created: MessageDeliveries::MessageDelivery.created_today.size,
  #     messages_created_end:
  #     messages_sent_end: message_delivery.sent.last.updated_at,
  #     sum_messages_sent: message_delivery.sent.size,
  #     sum_messages_sent_by_sms: message_delivery.sent.where(sms_allowed: true).size,
  #     sum_messages_sent_by_android: sum_cell_phone_system_from(message_delivery, 1),
  #     sum_messages_sent_by_ios: sum_cell_phone_system_from(message_delivery, 0))
  # end

  # def self.sum_cell_phone_system_from(message_delivery, system)
  #   message_delivery.by_cell_phone_system(system).size
  # end

end
