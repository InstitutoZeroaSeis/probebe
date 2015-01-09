require 'rails_helper'

RSpec.describe MessageDeliveries::MessageDelivery, :type => :model do

  describe ".created_today" do
    it "is expected to filter out registers created before today" do
      create_list(:message_delivery, 3, created_at: 1.day.ago)
      create(:message_delivery)
      expect(MessageDeliveries::MessageDelivery.created_today.count).to eq(1)
    end

    it "is expected to return no records if no one was created today" do
      create_list(:message_delivery, 3, created_at: 1.day.ago)
      expect(MessageDeliveries::MessageDelivery.created_today.count).to eq(0)
    end
  end

  describe ".not_sent" do
    it "is expected to filter out not yet sent messages" do
      create_list(:message_delivery, 3, :sent)
      create(:message_delivery, :not_sent)
      expect(MessageDeliveries::MessageDelivery.not_sent.count).to eq(1)
    end

    it "is expected to return no records if no messages have the not_sent status" do
      create_list(:message_delivery, 3, :sent)
      expect(MessageDeliveries::MessageDelivery.not_sent.count).to eq(0)
    end
  end

end
