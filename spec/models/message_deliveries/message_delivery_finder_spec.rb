require 'rails_helper'

describe MessageDeliveries::MessageDeliveryFinder, type: :model do

  context "with two messages to be sent" do
    it "is expected to deliver them to the user devices" do
      message_deliveries = create_list(:message_delivery, 4, :sent, :with_profile)
      message_deliveries = create_list(:message_delivery, 1, :not_sent, :with_profile)
      finder = MessageDeliveries::MessageDeliveryFinder.new
      finder.find_and_deliver_messages
      expect(MessageDeliveries::MessageDelivery.sent.count).to eq(5)
      expect(MessageDeliveries::MessageDelivery.not_sent.count).to eq(0)
    end
  end

end
