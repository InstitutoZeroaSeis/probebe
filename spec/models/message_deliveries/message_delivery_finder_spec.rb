require 'rails_helper'

describe MessageDeliveries::MessageDeliveryFinder, type: :model do

  describe ".find_and_deliver_messages" do
    subject { create(:message_delivery, :not_sent) }

    it "is expected to set the delivery date when delivering" do
      allow_any_instance_of(MessageDeliveries::MessageSender).to receive(:send_to_device).
        and_return(true)
      expect(subject.delivery_date).to be_nil

      MessageDeliveries::MessageDeliveryFinder.find_and_deliver_messages

      subject.reload
      expect(subject.delivery_date).to_not be_nil
    end
  end

  context "with two messages to be sent" do
    before { create_list(:message_delivery, 4, :sent) }
    before { create(:message_delivery, :not_sent) }

    it "is expected to deliver them to the user devices" do
      allow_any_instance_of(MessageDeliveries::MessageSender).to receive(:send_to_device).
        and_return(true)
      MessageDeliveries::MessageDeliveryFinder.find_and_deliver_messages
      expect(MessageDeliveries::MessageDelivery.sent.count).to eq(5)
      expect(MessageDeliveries::MessageDelivery.not_sent.count).to eq(0)
    end
  end

end
