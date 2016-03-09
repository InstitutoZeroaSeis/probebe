class AddDefaultValueToManagerDeliveryMassage < ActiveRecord::Migration
  def change
    change_column :message_deliveries_manager_message_deliveries, :sum_messages_sent, :integer, :default => 0
  end
end
