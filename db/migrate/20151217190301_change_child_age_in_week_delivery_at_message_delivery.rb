class ChangeChildAgeInWeekDeliveryAtMessageDelivery < ActiveRecord::Migration
  def change
    change_column :message_deliveries, :child_age_in_week_at_delivery, :integer
  end
end
