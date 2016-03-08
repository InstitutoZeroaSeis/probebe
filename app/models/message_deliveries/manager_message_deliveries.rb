class MessageDeliveries::ManagerMessageDeliveries < ActiveRecord::Base
  self.table_name = 'message_deliveries_manager_message_deliveries'

  def counter_increase(message_delivery)
    messages_sent_end = message_delivery.updated_at
    case message_delivery.was_sent_through
       when 'sms' then self.sum_messages_sent_by_sms += 1
       when "ios" then self.sum_messages_sent_by_ios += 1
       when "android" then self.sum_messages_sent_by_android += 1
    end
  end

end
