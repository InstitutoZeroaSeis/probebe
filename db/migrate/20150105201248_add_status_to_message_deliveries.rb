class AddStatusToMessageDeliveries < ActiveRecord::Migration
  def change
    add_column :message_deliveries, :status, :integer, default: 0
  end
end
