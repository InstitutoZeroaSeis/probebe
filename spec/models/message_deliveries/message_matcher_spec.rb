require 'rails_helper'

RSpec.describe MessageDeliveries::MessageMatcher, :type => :model do
before(:each) { @system_date = MessageDeliveries::SystemDate.new }
  context "with two message applicable for child" do
    subject { MessageDeliveries::MessageMatcher.new(Message.journalistic, @profile.children.first, @system_date).find_message_for_child }
    before { @profile = create(:profile, children: create_list(:child, 1, birth_date: 5.months.ago)) }
    before { @message1 = create(:message, :with_journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born') }
    before { @message2 = create(:message, :with_journalistic_article, :both, minimum_valid_week: 10, baby_target_type: 'born') }
    it { is_expected.to match_array([@message1, @message2]) }
  end

  context "with two message applicable for child" do
    context "one of message already sent for profile" do
      subject { MessageDeliveries::MessageMatcher.new(Message.journalistic, @profile.children.first, @system_date).find_message_for_child }
      before { @profile = create(:profile, children: create_list(:child, 1, birth_date: 5.months.ago)) }
      before { @message1 = create(:message, :with_journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born') }
      before { @message2 = create(:message, :with_journalistic_article, :both, minimum_valid_week: 10, baby_target_type: 'born') }
      before { MessageDeliveries::MessageDelivery.create!(profile: @profile, message: @message1) }
      it { is_expected.to match_array([@message2]) }
    end
  end

  context "with two message applicable for child" do
    context "message from same article" do
      subject { MessageDeliveries::MessageMatcher.new(Message.journalistic, @profile.children.first, @system_date).find_message_for_child }
      before { @profile = create(:profile, children: create_list(:child, 1, birth_date: 5.months.ago)) }
      before { @message1 = create(:message, :with_journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born') }
      before { @message2 = create(:message, :with_journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born') }
      it { is_expected.to match_array([@message1, @message2]) }
    end
  end
end
