require 'rails_helper'

RSpec.describe MessageSender, :type => :model do

  context "With an already sent message" do
    before { @message = create(:message, maximum_valid_week: 12, baby_target_type: 'born') }
    before { @profile = create(:profile, children: create_list(:child, 1, birth_date: 3.months.ago)) }
    before { @finder = ProfileFinder.new(@message) }
    before { MessageDelivery.create!(message: @message, profiles: [@profile])}
    it "Does not send the same message again" do
      expect(@profile.message_deliveries.count).to eq(1)
      MessageSender.new(@finder).send_messages
      expect(@profile.message_deliveries.count).to eq(1)
    end
  end

end
