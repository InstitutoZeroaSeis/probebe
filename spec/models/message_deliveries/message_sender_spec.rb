require 'rails_helper'

RSpec.describe MessageDeliveries::MessageSender, :type => :model do
  context "with a profile that has only cell phone" do
    let (:message_delivery) { create(:message_delivery, :with_profile) }

    it "is expected to send the message to that phone" do
      allow(ProBebeConfig).to receive(:deliver_sms?).and_return(true)
      expect(MessageDeliveries::SpringWsdl).to receive(:send_message).with(message_delivery.profile.cell_phones.first.full_number, message_delivery.message.text).and_return(true)

      sender = MessageDeliveries::MessageSender.new message_delivery

      expect(sender.send_to_device).to eq(true)
    end
  end

  context "with a profile that has one registered device" do
    before { Rpush::Gcm::App.create!(name: 'pro-bebe-android', connections: 1, auth_key: "dummy") }

    it "is expected to send the message to that phone" do
      sender = MessageDeliveries::MessageSender.new create(:message_delivery, :with_profile, profile: create(:profile, :with_device_registration))
      expect(sender.send_to_device).to eq(true)
      expect(Rpush::Gcm::Notification.count).to eq(1)
    end

  end

  context "with ProBebeConfig.deliver_sms set to false" do
    it "is expected to not deliver sms" do
      expect(ProBebeConfig).to receive(:deliver_sms?).and_return(false)
      sender = MessageDeliveries::MessageSender.new create(:message_delivery, :with_profile)

      expect(MessageDeliveries::SpringWsdl).to_not receive(:send_message)

      sender.send_to_device
    end
  end

  context "with ProBebeConfig.deliver_sms set to true" do
    it "is expected to deliver sms" do
      expect(ProBebeConfig).to receive(:deliver_sms?).and_return(true)
      sender = MessageDeliveries::MessageSender.new create(:message_delivery, :with_profile)

      expect(MessageDeliveries::SpringWsdl).to receive(:send_message)

      sender.send_to_device
    end
  end
end
