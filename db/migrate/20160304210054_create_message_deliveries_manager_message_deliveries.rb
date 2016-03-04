class CreateMessageDeliveriesManagerMessageDeliveries < ActiveRecord::Migration
  def change
    create_table :message_deliveries_manager_message_deliveries do |t|
      t.date :messages_created_start
      t.date :messages_created_end
      t.date :messages_sent_start
      t.date :messages_sent_end
      t.integer :sum_messages_created
      t.integer :sum_messages_sent
      t.integer :sum_messages_sent_by_sms
      t.integer :sum_messages_sent_by_android
      t.integer :sum_messages_sent_by_ios

      t.timestamps
    end
  end
end
