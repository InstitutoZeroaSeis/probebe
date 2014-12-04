require 'rails_helper'

RSpec.describe MessageSender, :type => :model do
  before(:each) { @system_date = SystemDate.new }
  context "with many messages send message randomly" do
    subject{ MessageSender.new(@message_finder).send_messages(Date.today).message }
    before { @profile = create(:profile, children: create_list(:child, 1, birth_date: 5.months.ago)) }
    before { @article1 = create(:journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born', messages: create_list(:message, 10)) }
    before { @article2 = create(:journalistic_article, :both, minimum_valid_week: 10, baby_target_type: 'born', messages: create_list(:message, 10)) }
    before { @article_finder = ArticlesFinder.new(Articles::JournalisticArticle.all, @profile.children.first, @system_date) }
    before { @message_finder = MessageFinder.new(@article_finder) }
    before { @message_sender = MessageSender.new(@message_finder).send_messages(Date.today) }
    it { is_expected.not_to eq(@message_sender.message) }
  end

  context "with only one message and already sent before" do
    subject{ MessageSender.new(@message_finder).send_messages(Date.today) }
    before { @profile = create(:profile, children: create_list(:child, 1, birth_date: 5.months.ago)) }
    before { @article1 = create(:journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born', messages: create_list(:message, 1)) }
    before { @message1 = @article1.messages.first}
    before { MessageDelivery.create!(profile: @profile, message: @message1) }
    before { @article_finder = ArticlesFinder.new(Articles::JournalisticArticle.all, @profile.children.first, @system_date) }
    before { @message_finder = MessageFinder.new(@article_finder) }
    it { is_expected.to be_nil }
  end

  context "with no message for that profile" do
    subject{ MessageSender.new(@message_finder).send_messages(Date.today) }
    before { @profile = create(:profile, children: create_list(:child, 1, birth_date: 5.months.ago)) }
    before { @article1 = create(:journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'pregnancy', messages: create_list(:message, 12)) }
    before { @article_finder = ArticlesFinder.new(Articles::JournalisticArticle.all, @profile.children.first, @system_date) }
    before { @message_finder = MessageFinder.new(@article_finder) }
    it { is_expected.to be_nil }
  end


end
