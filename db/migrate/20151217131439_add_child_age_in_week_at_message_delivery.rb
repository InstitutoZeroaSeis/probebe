class AddChildAgeInWeekAtMessageDelivery < ActiveRecord::Migration
  def change
    add_column :message_deliveries, :child_age_in_week_at_delivery, :date
  end
end
