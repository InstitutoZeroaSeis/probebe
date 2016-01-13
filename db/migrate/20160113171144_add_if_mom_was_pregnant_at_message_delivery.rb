class AddIfMomWasPregnantAtMessageDelivery < ActiveRecord::Migration
  def change
    add_column :message_deliveries, :mon_is_pregnat, :boolean
  end
end
