require 'rails_helper'

RSpec.describe MessageSender, :type => :model do

  context "with an already sent message" do
    before { @article = create(:journalistic_article, maximum_valid_week: 14, baby_target_type: 'born', messages: create_list(:message, 1, text: "Text")) }
    before { @profile = create(:profile, children: create_list(:child, 1, birth_date: 3.months.ago)) }
    before { @finder = ProfileFinder.new(@article) }
    before { MessageDelivery.create!(message: @article.messages.first, profiles: [@profile])}
    it "does not send the same message again" do
      expect(@profile.message_deliveries.count).to eq(1)
      MessageSender.new(@finder).send_messages
      expect(@profile.message_deliveries.count).to eq(1)
    end
  end

  context "with two message from different articles" do
    before { @article = create(:journalistic_article, maximum_valid_week: 14, baby_target_type: 'born', messages: create_list(:message, 1, text: "Text")) }
    before { @article2 = create(:journalistic_article, minimum_valid_week: 12 , baby_target_type: 'born', messages: create_list(:message, 1, text: "Text")) }
    before { @profile = create(:profile, children: create_list(:child, 1, birth_date: 3.months.ago)) }
    before { @finder = ProfileFinder.new(@article) }
    before { @finder2 = ProfileFinder.new(@article2) }
    it "Expect to have two message again" do
      MessageSender.new(@finder).send_messages
      MessageSender.new(@finder2).send_messages
      expect(@profile.message_deliveries.count).to eq(2)
    end
  end

  context "with message of same article" do
    before { @article = create(:authorial_article, maximum_valid_week: 14, baby_target_type: 'born', messages: create_list(:message, 2, text: "Text")) }
    before { @profile = create(:profile, children: create_list(:child, 1, birth_date: 3.months.ago)) }
    before { @finder = ProfileFinder.new(@article) }
    before { MessageDelivery.create!(message: @article.messages.first, profiles: [@profile])}
    it "expect to send two message" do
      expect(@profile.message_deliveries.count).to eq(1)
      MessageSender.new(@finder).send_messages
      expect(@profile.message_deliveries.count).to eq(2)
    end
  end

end
