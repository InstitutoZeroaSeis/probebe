require 'rails_helper'

RSpec.describe MessageDeliveries::MessageSender, :type => :model do
  before(:each) { @system_date = MessageDeliveries::SystemDate.new }

  context "with only one message and already sent before" do
    before { @child = create(:child, :with_profile, birth_date: 5.months.ago) }
    before { @message = create(:message, :with_journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born') }
    before { MessageDeliveries::MessageDelivery.create!(child: @child, message: @message) }

    subject { MessageDeliveries::MessageSender.new(@system_date).send_messages }

    it { is_expected.to be_empty }
  end

  context "with no message for that profile" do
    before { @child = create(:child, :with_profile, birth_date: 5.months.ago) }
    before { create(:message, :with_journalistic_article, :male, maximum_valid_week: 10, baby_target_type: 'pregnancy') }

    subject { MessageDeliveries::MessageSender.new(@system_date).send_messages }
    it { is_expected.to be_empty }
  end

  context "with a message targeting female with up to 24 months of pregnancy" do
    context "and with a children in its 5th month of gestation" do
      before { @child = create(:child, :with_profile, birth_date: (Child::PREGNANCY_DURATION_IN_WEEKS.weeks - 5.months).from_now) }
      before { @message = create(:message, :with_journalistic_article, :male, maximum_valid_week: 24, baby_target_type: 'pregnancy') }

      subject{ MessageDeliveries::MessageSender.new(@system_date).send_messages }

      it "is expected to send a message for the given child" do
        expect(subject.count).to eq(1)
        expect(subject.first.message).to eq(@message)
        expect(subject.first.child).to eq(@child)
      end
    end
  end
end
