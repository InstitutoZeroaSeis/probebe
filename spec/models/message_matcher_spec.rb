require 'rails_helper'

RSpec.describe MessageMatcher, :type => :model do
before(:each) { @system_date = SystemDate.new }
  context "with two message applicable for child" do
    subject { MessageMatcher.new(@articles_matcher).find_message_for_child }
    before { @profile = create(:profile, children: create_list(:child, 1, birth_date: 5.months.ago)) }
    before { @article1 = create(:journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born', messages: create_list(:message, 1)) }
    before { @article2 = create(:journalistic_article, :both, minimum_valid_week: 10, baby_target_type: 'born', messages: create_list(:message, 1)) }
    before { @message1 = @article1.messages.first}
    before { @message2 = @article2.messages.first}
    before { @articles_matcher = ArticlesMatcher.new(Articles::JournalisticArticle.all, @profile.children.first, @system_date) }
    it { is_expected.to match_array([@message1, @message2]) }
  end

  context "with two message applicable for child" do
    context "one of message already sent for profile" do
      subject { MessageMatcher.new(@articles_matcher).find_message_for_child }
      before { @profile = create(:profile, children: create_list(:child, 1, birth_date: 5.months.ago)) }
      before { @article1 = create(:journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born', messages: create_list(:message, 1)) }
      before { @article2 = create(:journalistic_article, :both, minimum_valid_week: 10, baby_target_type: 'born', messages: create_list(:message, 1)) }
      before { @message1 = @article1.messages.first}
      before { @message2 = @article2.messages.first}
      before { MessageDelivery.create!(profile: @profile, message: @message1) }
      before { @articles_matcher = ArticlesMatcher.new(Articles::JournalisticArticle.all, @profile.children.first, @system_date) }
      it { is_expected.to match_array([@message2]) }
    end
  end

  context "with two message applicable for child" do
    context "message from same article" do
      subject { MessageMatcher.new(@articles_matcher).find_message_for_child }
      before { @profile = create(:profile, children: create_list(:child, 1, birth_date: 5.months.ago)) }
      before { @article1 = create(:journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born', messages: create_list(:message, 2)) }
      before { @message1 = @article1.messages.first}
      before { @message2 = @article1.messages.second}
      before { @articles_matcher = ArticlesMatcher.new(Articles::JournalisticArticle.all, @profile.children.first, @system_date) }
      it { is_expected.to match_array([@message1, @message2]) }
    end
  end
end
