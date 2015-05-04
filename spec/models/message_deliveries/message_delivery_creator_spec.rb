require 'rails_helper'

RSpec.describe MessageDeliveries::MessageDeliveryCreator, type: :model do
  before(:each) do
    @system_date = MessageDeliveries::SystemDate.new
    @profile = create(:profile, :without_children)
  end

  describe '.create_deliveries_for_all_children' do
    before { @child = create(:child, birth_date: 5.months.ago, profile: @profile) }
    before { @message = create(:message, :with_journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born') }
    subject { MessageDeliveries::MessageDeliveryCreator.new(@system_date).create_deliveries_for_all_children }
    it 'is expected to correctly create the message delivery' do
      expect(subject.first.message).to eq(@message)
      expect(subject.first.child).to eq(@child)
      expect(subject.first.message_for_test).to be false
      expect(subject.first.cell_phone_number).to eq(@child.primary_cell_phone_number)
      expect(subject.first.device_registrations).to eq(@child.device_registrations)
      expect(subject.first.sms_allowed).to eq(@child.authorized_receive_sms)
      expect(subject.first.status).to eq('not_sent')
    end
  end

  context 'with only one message and already sent before' do
    before { @child = create(:child, profile: @profile, birth_date: 5.months.ago) }
    before { @message = create(:message, :with_journalistic_article, :male, maximum_valid_week: 22, baby_target_type: 'born') }
    before { MessageDeliveries::MessageDelivery.create!(child: @child, message: @message) }
    before { @before_message_count = MessageDeliveries::MessageDelivery.count }

    subject { MessageDeliveries::MessageDeliveryCreator.new(@system_date).create_deliveries_for_all_children }

    it 'is expected to create no additional messages' do
      expect(MessageDeliveries::MessageDelivery.count).to eq(@before_message_count)
    end
  end

  context 'with no message for that profile' do
    before { @child = create(:child, profile: @profile, birth_date: 5.months.ago) }
    before { create(:message, :with_journalistic_article, :male, maximum_valid_week: 10, baby_target_type: 'pregnancy') }

    subject { MessageDeliveries::MessageDeliveryCreator.new(@system_date).create_deliveries_for_all_children }

    it 'is expected to deliver no messages' do
      expect(MessageDeliveries::MessageDelivery.count).to eq(0)
    end
  end

  context 'with a message targeting female with up to 24 months of pregnancy' do
    context 'and with a children in its 5th month of gestation' do
      before { @child = create(:child, profile: @profile, birth_date: (Child::PREGNANCY_DURATION_IN_WEEKS.weeks - 5.months).from_now) }
      before { @message = create(:message, :with_journalistic_article, :male, maximum_valid_week: 24, baby_target_type: 'pregnancy') }
      it 'is expected to send a message for the given child' do
        MessageDeliveries::MessageDeliveryCreator.new(@system_date).create_deliveries_for_all_children
        expect(MessageDeliveries::MessageDelivery.count).to eq(1)
        expect(MessageDeliveries::MessageDelivery.first.message).to eq(@message)
        expect(MessageDeliveries::MessageDelivery.first.child).to eq(@child)
      end
    end
  end
end
