class CreateMessageDeliveries < ActiveRecord::Migration
  def change
    create_table :message_deliveries do |t|
      t.references :message
      t.references :profile
      t.date :delivery_date
      t.boolean :message_for_test, default: false
      t.timestamps
    end
  end
end
