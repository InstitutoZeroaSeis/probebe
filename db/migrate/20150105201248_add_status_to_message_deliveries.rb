class AddStatusToMessageDeliveries < ActiveRecord::Migration
  def change
    add_column :message_deliveries, :status, :integer
  end
end
