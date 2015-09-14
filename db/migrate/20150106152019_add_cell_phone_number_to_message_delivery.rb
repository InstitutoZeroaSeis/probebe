class AddCellPhoneNumberToMessageDelivery < ActiveRecord::Migration
  def change
    add_column :message_deliveries, :cell_phone_number, :string
  end
end
