class CreateJoinTableMessageDeliveriesProfiles < ActiveRecord::Migration
  def change
    create_join_table :message_deliveries, :profiles do |t|
      # t.index [:message_delivery_id, :profile_id]
      # t.index [:profile_id, :message_delivery_id]
    end
  end
end
