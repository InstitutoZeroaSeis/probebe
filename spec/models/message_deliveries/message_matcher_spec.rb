require 'rails_helper'

RSpec.describe MessageDeliveries::MessageMatcher, :type => :model do
  before(:each) { @system_date = MessageDeliveries::SystemDate.new }
  context "with two message applicable for child" do
    subject { MessageDeliveries::MessageMatcher.new(Message.journalistic, @child, @system_date).filter_messages_for_child }
    before { @child = create(:child, birth_date: 5.months.ago) }
    before { @message1 = create(:message, :with_journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born') }
    before { @message2 = create(:message, :with_journalistic_article, :both, minimum_valid_week: 10, baby_target_type: 'born') }
    it { is_expected.to match_array([@message1, @message2]) }
  end

  context "with two message applicable for child" do
    context "one of message already sent for profile" do
      subject { MessageDeliveries::MessageMatcher.new(Message.journalistic, @child, @system_date).filter_messages_for_child }
      before { @child = create(:child, birth_date: 5.months.ago) }
      before { @message1 = create(:message, :with_journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born') }
      before { @message2 = create(:message, :with_journalistic_article, :both, minimum_valid_week: 10, baby_target_type: 'born') }
      before { MessageDeliveries::MessageDelivery.create!(child: @child, message: @message1) }
      it { is_expected.to match_array([@message2]) }
    end
  end

  context "with two message applicable for child" do
    context "message from same article" do
      subject { MessageDeliveries::MessageMatcher.new(Message.journalistic, @child, @system_date).filter_messages_for_child }
      before { @child = create(:child, birth_date: 5.months.ago) }
      before { @message1 = create(:message, :with_journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born') }
      before { @message2 = create(:message, :with_journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born') }
      it { is_expected.to match_array([@message1, @message2]) }
    end
  end

  context "with child born, male and five months old" do
    context "and with messages that are applicable for that child" do
      before { @child = create(:child, :with_profile, birth_date: 5.months.ago) }
      before { @message1 = create(:message, :with_journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born') }
      before { @message2 = create(:message, :with_journalistic_article, :both, minimum_valid_week: 10, baby_target_type: 'born') }
      before { @system_date = MessageDeliveries::SystemDate.new }

      subject { MessageDeliveries::MessageMatcher.new(Message.journalistic, @child, @system_date).filter_messages_for_child }

      it { is_expected.to match_array([@message1, @message2]) }
    end
  end

  context "with a born child, female and half an year old" do
    context "return empty if no applicable messages were found for that child" do
      before { @child = create(:child, birth_date: 18.months.ago) }
      before { @message1 = create(:message, :with_journalistic_article, :female, minimum_valid_week: 12, maximum_valid_week: 22, baby_target_type: 'born') }
      before { @message2 = create(:message, :with_journalistic_article, :both, maximum_valid_week: 10, baby_target_type: 'born') }
      before { @system_date = MessageDeliveries::SystemDate.new }

      subject { MessageDeliveries::MessageMatcher.new(Message.journalistic, @child, @system_date).filter_messages_for_child }

      it { is_expected.to be_empty }
    end
  end

  context "with pregnancy child, no gender specified, pregnancy for about 5 months" do
    context "and articles that applicable for that child " do
      before { @child = create(:child, :with_profile, birth_date: 7.months.from_now) }
      before { @message1 = create(:message, :with_journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'pregnancy') }
      before { @message2 = create(:message, :with_journalistic_article, :male, minimum_valid_week: 10, maximum_valid_week: 25, baby_target_type: 'pregnancy') }
      before { @system_date = MessageDeliveries::SystemDate.new }

      subject { MessageDeliveries::MessageMatcher.new(Message.journalistic, @child, @system_date).filter_messages_for_child }

      it { is_expected.to match_array([@message1, @message2]) }
    end
  end

  context "with pregnancy child, no gender specified, pregnancy for about 2 months" do
    context "and 4 articles with only 2 of than being applicable" do
      before { @child = create(:child, :with_profile, birth_date: 7.months.from_now) }
      before { @message1 = create(:message, :with_journalistic_article, :male, maximum_valid_week: 14, baby_target_type: 'pregnancy') }
      before { @message2 = create(:message, :with_journalistic_article, :male, minimum_valid_week: 3, baby_target_type: 'pregnancy') }
      before { @message3 = create(:message, :with_journalistic_article, :both, minimum_valid_week: 16, baby_target_type: 'pregnancy') }
      before { @message4 = create(:message, :with_journalistic_article, :both, minimum_valid_week: 10, baby_target_type: 'born') }
      before { @system_date = MessageDeliveries::SystemDate.new }

      subject { MessageDeliveries::MessageMatcher.new(Message.journalistic, @child, @system_date).filter_messages_for_child }

      it { is_expected.to match_array([@message1, @message2]) }
    end
  end

  context "with articles, one is ending valiates maximum weeks" do
    context "order them by priority of ending valid week" do
      before { @child = create(:child, :with_profile, birth_date: 7.months.from_now) }
      before { @message1 = create(:message, :with_journalistic_article, :male, minimum_valid_week: 9, maximum_valid_week: 13, baby_target_type: 'pregnancy') }
      before { @message2 = create(:message, :with_journalistic_article, :male, minimum_valid_week: 7, maximum_valid_week: 11, baby_target_type: 'pregnancy') }
      before { @message3 = create(:message, :with_journalistic_article, :male, minimum_valid_week: 7, maximum_valid_week: 12, baby_target_type: 'pregnancy') }
      before { @system_date = MessageDeliveries::SystemDate.new }

      subject { MessageDeliveries::MessageMatcher.new(Message.journalistic, @child, @system_date).filter_messages_for_child }

      it { is_expected.to match_array([@message2, @message3, @message1]) }
    end
  end

  context "with articles and system date with date different from today" do
    context "order them by priority of ending valid week" do
      before { @child = create(:child, :with_profile, birth_date: 7.months.from_now) }
      before { @message1 = create(:message, :with_journalistic_article, :male, minimum_valid_week: 9, maximum_valid_week: 20, baby_target_type: 'pregnancy') }
      before { @message2 = create(:message, :with_journalistic_article, :male, minimum_valid_week: 7, maximum_valid_week: 17, baby_target_type: 'pregnancy') }
      before { @message3 = create(:message, :with_journalistic_article, :male, minimum_valid_week: 7, baby_target_type: 'pregnancy') }
      before { @system_date = MessageDeliveries::SystemDate.new(5.weeks.from_now.to_date.to_s) }

      subject { MessageDeliveries::MessageMatcher.new(Message.journalistic, @child, @system_date).filter_messages_for_child }

      it { is_expected.to match_array([@message2, @message1, @message3]) }
    end
  end

end
