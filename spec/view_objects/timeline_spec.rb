require 'rails_helper'

RSpec.describe Timeline do
  describe ".timeline_days" do
    context 'given some message deliveries' do
      let(:deliveries) do
        [
          build_stubbed(:message_delivery, delivery_date: 7.days.ago),
          build_stubbed(:message_delivery, delivery_date: 5.days.ago),
          build_stubbed(:message_delivery, delivery_date: 3.days.ago)
        ]
      end
      expected_dates = [ DateTime.now, 1.days.ago, 2.days.ago, 3.days.ago,
                         4.days.ago, 5.days.ago, 6.days.ago, 7.days.ago ]
        .map(&:beginning_of_day)
      subject { Timeline.new(deliveries, expected_dates) }
      it 'should return all days even if they do not have events' do
        dates = subject.timeline_days.map(&:date).map(&:beginning_of_day)
        expect(dates.count).to eq(8)
        expect(dates).to eq expected_dates
      end
    end

    context 'with an empty deliveries' do
      subject { Timeline.new([], [1.days.ago, 2.days.ago]) }
      its(:timeline_days) { should eq([]) }
    end
  end
end
