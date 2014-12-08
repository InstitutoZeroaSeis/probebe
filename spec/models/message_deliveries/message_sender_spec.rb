require 'rails_helper'

RSpec.describe MessageDeliveries::MessageSender, :type => :model do
  before(:each) { @system_date = MessageDeliveries::SystemDate.new }
  context "with only one message and already sent before" do
    subject{ MessageDeliveries::MessageSender.new(@message_matcher).send_messages(Date.today) }
    before { @profile = create(:profile, children: create_list(:child, 1, birth_date: 5.months.ago)) }
    before { @article1 = create(:journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born', messages: create_list(:message, 1)) }
    before { @message1 = @article1.messages.first}
    before { MessageDeliveries::MessageDelivery.create!(profile: @profile, message: @message1) }
    before { @articles_matcher = MessageDeliveries::ArticlesMatcher.new(Articles::JournalisticArticle.all, @profile.children.first, @system_date) }
    before { @message_matcher = MessageDeliveries::MessageMatcher.new(@articles_matcher) }
    it { is_expected.to be_nil }
  end

  context "with no message for that profile" do
    subject{ MessageDeliveries::MessageSender.new(@message_matcher).send_messages(Date.today) }
    before { @profile = create(:profile, children: create_list(:child, 1, birth_date: 5.months.ago)) }
    before { @article1 = create(:journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'pregnancy', messages: create_list(:message, 12)) }
    before { @articles_matcher = MessageDeliveries::ArticlesMatcher.new(Articles::JournalisticArticle.all, @profile.children.first, @system_date) }
    before { @message_matcher = MessageDeliveries::MessageMatcher.new(@articles_matcher) }
    it { is_expected.to be_nil }
  end
end
