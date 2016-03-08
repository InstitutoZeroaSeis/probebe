class ChangeColumnTypeAtManageMessageDeliveries < ActiveRecord::Migration
  def change
    change_column :message_deliveries_manager_message_deliveries, :messages_created_start, :datetime
    change_column :message_deliveries_manager_message_deliveries, :messages_created_end, :datetime
    change_column :message_deliveries_manager_message_deliveries, :messages_sent_start, :datetime
    change_column :message_deliveries_manager_message_deliveries, :messages_sent_end, :datetime
  end
end
