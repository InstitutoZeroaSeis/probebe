class UpdateIfMomWasPregnantAtMessageDelivery < ActiveRecord::Migration
  def change
    MessageDeliveries::MessageDelivery.all.each do |message|
      if !message.child.nil?
        message.mon_is_pregnat = message.child.pregnancy?(MessageDeliveries::SystemDate.new(message.delivery_date))
        message.save
      end
    end
  end
end
