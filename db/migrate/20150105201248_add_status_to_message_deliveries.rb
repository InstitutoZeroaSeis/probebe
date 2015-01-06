class AddStatusToMessageDeliveries < ActiveRecord::Migration
  class MessageDelivery < ActiveRecord::Base
  end

  def change
    add_column :message_deliveries, :status, :integer, default: 0
    MessageDelivery.reset_column_information
    reversible do |dir|
      dir.up { MessageDelivery.update_all status: 1 }
    end
  end
end
