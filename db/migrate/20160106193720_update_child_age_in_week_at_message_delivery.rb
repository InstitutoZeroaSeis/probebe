class UpdateChildAgeInWeekAtMessageDelivery < ActiveRecord::Migration
  def change
    MessageDeliveries::MessageDelivery.all.each do |message|
      if !message.child.nil?
        message.child_age_in_week_at_delivery = message.child.age_in_weeks(MessageDeliveries::SystemDate.new(message.delivery_date))
        message.save
      end
    end
  end
end
