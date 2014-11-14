require 'rails_helper'

RSpec.describe MessageSender, :type => :model do

  context "with an already sent message" do
    before { @article = create(:authorial_article, maximum_valid_week: 14, baby_target_type: 'born', messages: create_list(:message, 1, text: "Text")) }
    before { @profile = create(:profile, children: create_list(:child, 1, birth_date: 3.months.ago)) }
    before { @finder = ProfileFinder.new(@article) }
    before { MessageDelivery.create!(message: @article.messages.first, profiles: [@profile])}
    it "does not send the same message again" do
      expect(@profile.message_deliveries.count).to eq(1)
      MessageSender.new(@finder).send_messages
      expect(@profile.message_deliveries.count).to eq(1)
    end
  end


end
