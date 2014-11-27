require 'rails_helper'

RSpec.describe MessageFinder, :type => :model do

  context "with two message applicable for child" do
    subject { MessageFinder.new(@article_finder).find_message_for_child }
    before { @profile = create(:profile, children: create_list(:child, 1, birth_date: 5.months.ago)) }
    before { @article1 = create(:journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born', messages: create_list(:message, 1)) }
    before { @article2 = create(:journalistic_article, :both, minimum_valid_week: 10, baby_target_type: 'born', messages: create_list(:message, 1)) }
    before { @message1 = @article1.messages.first}
    before { @message2 = @article2.messages.first}
    before { @article_finder = ArticlesFinder.new(Articles::JournalisticArticle.all, @profile.children.first) }
    it { is_expected.to match_array([@message1, @message2]) }
  end

  context "with two message applicable for child" do
    context "one of message already sent for profile" do
      subject { MessageFinder.new(@article_finder).find_message_for_child }
      before { @profile = create(:profile, children: create_list(:child, 1, birth_date: 5.months.ago)) }
      before { @article1 = create(:journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born', messages: create_list(:message, 1)) }
      before { @article2 = create(:journalistic_article, :both, minimum_valid_week: 10, baby_target_type: 'born', messages: create_list(:message, 1)) }
      before { @message1 = @article1.messages.first}
      before { @message2 = @article2.messages.first}
      before { MessageDelivery.create!(profile: @profile, message: @message1) }
      before { @article_finder = ArticlesFinder.new(Articles::JournalisticArticle.all, @profile.children.first) }
      it { is_expected.to match_array([@message2]) }
    end
  end
end
