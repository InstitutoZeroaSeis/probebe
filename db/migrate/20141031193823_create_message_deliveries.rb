class CreateMessageDeliveries < ActiveRecord::Migration
  def change
    create_table :message_deliveries do |t|
      t.references :message
      t.references :profile
      t.timestamps
    end
  end
end
