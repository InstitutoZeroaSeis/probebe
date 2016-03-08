class ChangeDefaultValuesToIntergerAtManagerDeliveryMessage < ActiveRecord::Migration
  def change
    change_column :message_deliveries_manager_message_deliveries, :sum_messages_sent_by_sms, :integer, :default => 0
    change_column :message_deliveries_manager_message_deliveries, :sum_messages_sent_by_ios, :integer, :default => 0
    change_column :message_deliveries_manager_message_deliveries, :sum_messages_sent_by_android, :integer, :default => 0
  end
end
