require 'rails_helper'

RSpec.describe MessageDeliveries::MessageSender, :type => :model do
  before(:each) { @system_date = MessageDeliveries::SystemDate.new }

  context "with only one message and already sent before" do
    before { @child = create(:child, birth_date: 5.months.ago) }
    before { @profile = create(:profile, children: [@child]) }
    before { @article = create(:journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born', messages: create_list(:message, 1)) }
    before { @message = @article.messages.first }
    before { MessageDeliveries::MessageDelivery.create!(profile: @profile, message: @message) }

    subject { MessageDeliveries::MessageSender.new(@child, @system_date).send_message }
    it { is_expected.to be_nil }
  end

  context "with no message for that profile" do
    before { @child = create(:child, birth_date: 5.months.ago) }
    before { @profile = create(:profile, children: [@child]) }
    before { @article = create(:journalistic_article, :male, maximum_valid_week: 10, baby_target_type: 'pregnancy', messages: create_list(:message, 1)) }

    subject { MessageDeliveries::MessageSender.new(@child, @system_date).send_message }
    it { is_expected.to be_nil }
  end

  context "with a message targeting female with up to 24 months of pregnancy" do
    context "and with a children in its 5th month of gestation" do
      before { @child = create(:child, birth_date: (Child::PREGNANCY_DURATION_IN_WEEKS.weeks - 5.months).from_now) }
      before { @profile = create(:profile, children: [@child]) }
      before { @article = create(:journalistic_article, :male, maximum_valid_week: 24, baby_target_type: 'pregnancy', messages: create_list(:message, 1)) }

      subject{ MessageDeliveries::MessageSender.new(@child, @system_date).send_message }

      it { is_expected.to_not be_nil }
    end
  end
end
