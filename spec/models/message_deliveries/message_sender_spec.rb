require 'rails_helper'

RSpec.describe MessageDeliveries::MessageSender, :type => :model do
  context "with a profile that has only cell phone" do
    let (:profile) { create(:profile) }
    let (:message) { create(:message) }

    it "is expected to send the message to that phone" do
      allow(ProBebeConfig).to receive(:deliver_sms?).and_return(true)
      expect(MessageDeliveries::SpringWsdl).to receive(:send_message).with(profile.cell_phones.first.number, message.text).and_return(true)
      sender = MessageDeliveries::MessageSender.new(profile, message)

      expect(sender.send_to_device).to eq(true)
    end
  end

  context "with a profile that has one registered device" do
    before { Rpush::Gcm::App.create!(name: 'pro-bebe-android', connections: 1, auth_key: "dummy") }
    let (:device_registration) { create(:device_registration, :with_profile) }
    let (:profile) { device_registration.profile }
    let (:message) { create(:message) }

    it "is expected to send the message to that phone" do
      sender = MessageDeliveries::MessageSender.new(profile, message)
      expect(sender.send_to_device).to eq(true)
      expect(Rpush::Gcm::Notification.count).to eq(1)
    end

  end

  context "with ProBebeConfig.deliver_sms set to false" do
    let (:profile) { create(:profile) }
    let (:message) { create(:message) }
    it "is expected to not deliver sms" do
      expect(ProBebeConfig).to receive(:deliver_sms?).and_return(false)
      sender = MessageDeliveries::MessageSender.new(profile, message)
      expect(MessageDeliveries::SpringWsdl).to_not receive(:send_message)
      sender.send_to_device
    end
  end

  context "with ProBebeConfig.deliver_sms set to true" do
    let (:profile) { create(:profile) }
    let (:message) { create(:message) }
    it "is expected to deliver sms" do
      expect(ProBebeConfig).to receive(:deliver_sms?).and_return(true)
      sender = MessageDeliveries::MessageSender.new(profile, message)
      expect(MessageDeliveries::SpringWsdl).to receive(:send_message)
      sender.send_to_device
    end
  end
end
