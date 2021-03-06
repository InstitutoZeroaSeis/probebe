require 'rails_helper'

describe MessageDeliveries::MessageDeliveryFinder, type: :model do

  describe ".find_and_deliver_messages" do
    subject { create(:message_delivery, :not_sent) }

    it "is expected to set the delivery date when delivering" do
      allow_any_instance_of(MessageDeliveries::MessageSender).to receive(:send_to_device).
        and_return(true)
      expect(subject.delivery_date).to be_nil

      MessageDeliveries::MessageDeliveryFinder.find_and_deliver_messages(subject)

      subject.reload
      expect(subject.delivery_date).to_not be_nil
    end

    context "when its not possible to send the message" do
      it "expect to not mark as sent" do
        allow_any_instance_of(MessageDeliveries::MessageSender).to receive(:deliver_through_sms).
          and_return(false)
        expect(subject.delivery_date).to be_nil

        MessageDeliveries::MessageDeliveryFinder.find_and_deliver_messages(subject)

        subject.reload
        expect(subject.delivery_date).to be_nil
      end
    end
  end

  context "with two messages to be sent" do
    before { create_list(:message_delivery, 4, :sent) }
    before { @message_delivery = create(:message_delivery, :not_sent) }
    before { create(:manager_message_deliveries) }

    it "is expected to deliver them to the user devices" do
      allow_any_instance_of(MessageDeliveries::MessageSender).to receive(:send_to_device).
        and_return(true)

      MessageDeliveries::MessageDeliveryFinder.find_and_deliver_messages(@message_delivery)
      expect(MessageDeliveries::MessageDelivery.sent.count).to eq(5)
      expect(MessageDeliveries::MessageDelivery.not_sent.count).to eq(0)
    end
  end

end
