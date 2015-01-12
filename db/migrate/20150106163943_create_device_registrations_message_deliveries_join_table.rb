class CreateDeviceRegistrationsMessageDeliveriesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :device_registrations, :message_deliveries do |t|
      # t.index [:device_registration_id, :message_delivery_id]
      # t.index [:message_delivery_id, :device_registration_id]
    end
  end
end
