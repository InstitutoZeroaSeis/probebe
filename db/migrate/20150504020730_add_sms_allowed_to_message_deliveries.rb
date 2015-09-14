class AddSmsAllowedToMessageDeliveries < ActiveRecord::Migration
  def change
    add_column :message_deliveries, :sms_allowed, :boolean, default: false
  end
end
