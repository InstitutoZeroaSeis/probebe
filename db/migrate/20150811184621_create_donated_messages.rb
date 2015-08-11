class CreateDonatedMessages < ActiveRecord::Migration
  def change
    create_table :donated_messages do |t|
      t.references :message_delivery, index: true
      t.integer :donor_id, index: true
      t.timestamps
    end
  end
end
