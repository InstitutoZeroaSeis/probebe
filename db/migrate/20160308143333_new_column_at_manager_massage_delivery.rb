class NewColumnAtManagerMassageDelivery < ActiveRecord::Migration
  def change
    add_column :message_deliveries_manager_message_deliveries, :creator_jobs_end, :datetime
    remove_column :message_deliveries_manager_message_deliveries, :messages_created_end
    remove_column :message_deliveries_manager_message_deliveries, :messages_sent_start
  end
end
