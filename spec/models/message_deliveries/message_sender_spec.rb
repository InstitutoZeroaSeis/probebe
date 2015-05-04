require 'rails_helper'

RSpec.describe MessageDeliveries::MessageSender, type: :model do
  context 'with a message delivery that has no device registration' do
    it 'is expected to send the message via sms' do
      message_delivery = build_stubbed(:message_delivery)

      expect(ProBebeConfig).to receive(:deliver_sms?).and_return(true)
      expect(MessageDeliveries::SpringWsdl).to receive(:send_message).with(message_delivery.cell_phone_number, message_delivery.text, message_delivery.id).and_return(true)

      sender = MessageDeliveries::MessageSender.new(message_delivery)

      expect(sender.send_to_device).to eq(true)
    end
  end

  context 'with a message delivery that has one registered device' do
    before { Rpush::Gcm::App.create!(name: 'pro-bebe-android', connections: 1, auth_key: 'dummy') }
    let(:message_delivery) { build_stubbed(:message_delivery, :with_device_registrations) }

    it 'is expected to send the message to that device' do
      sender = MessageDeliveries::MessageSender.new(message_delivery)
      expect(sender.send_to_device).to eq(true)
      expect(Rpush::Gcm::Notification.count).to eq(1)
    end
  end

  context 'with ProBebeConfig.deliver_sms set to false' do
    let (:message_delivery) { build_stubbed(:message_delivery) }

    it 'is expected to not deliver sms' do
      expect(ProBebeConfig).to receive(:deliver_sms?).and_return(false)
      expect(MessageDeliveries::SpringWsdl).to_not receive(:send_message)

      sender = MessageDeliveries::MessageSender.new(message_delivery)

      sender.send_to_device
    end
  end

  context 'with ProBebeConfig.deliver_sms set to true' do
    let(:message_delivery) { build_stubbed(:message_delivery) }

    it 'is expected to deliver sms' do
      expect(ProBebeConfig).to receive(:deliver_sms?).and_return(true)
      expect(MessageDeliveries::SpringWsdl).to receive(:send_message)

      sender = MessageDeliveries::MessageSender.new(message_delivery)

      sender.send_to_device
    end
  end

  it 'sends a sms if the message is allowed to be sent' do
    allow(MessageDeliveries::SpringWsdl).to receive(:send_message)
    allow(ProBebeConfig).to receive(:deliver_sms?).and_return(true)
    message_delivery = build_stubbed(:message_delivery, sms_allowed: true)
    sender = MessageDeliveries::MessageSender.new(message_delivery)

    sender.send_to_device

    expect(MessageDeliveries::SpringWsdl).to have_received(:send_message)
  end

  it 'does not send a sms if the message is not allowed to be sent' do
    allow(MessageDeliveries::SpringWsdl).to receive(:send_message)
    allow(ProBebeConfig).to receive(:deliver_sms?).and_return(true)
    message_delivery = build_stubbed(:message_delivery, sms_allowed: false)
    sender = MessageDeliveries::MessageSender.new(message_delivery)

    sender.send_to_device

    expect(MessageDeliveries::SpringWsdl).to_not have_received(:send_message)
  end
end
