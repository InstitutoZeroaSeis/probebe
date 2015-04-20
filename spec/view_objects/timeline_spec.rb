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
      let(:deliveries_by_period) { [build_stubbed(:message_delivery, delivery_date: 3.days.ago)] }
      let(:expected_dates) { [ DateTime.now, 1.days.ago, 2.days.ago, 3.days.ago ].map(&:beginning_of_day) }

      subject { Timeline.new(deliveries, deliveries_by_period, expected_dates) }
      it 'should return all days even if they do not have events' do
        dates = subject.timeline_days.map(&:date).map(&:beginning_of_day)
        expect(dates.count).to eq(4)
        expect(dates).to eq expected_dates.reverse
      end
      it 'should return events in given period' do
        events = subject.timeline_days.select{|t| t.has_event?}
        expect(events.count).to eq(1)
      end
    end

    context 'with an empty deliveries events' do
      subject { Timeline.new([], [], [1.days.ago, 2.days.ago]) }
      it 'should return all days even if they do not have events' do
        dates = subject.timeline_days.map(&:date).map(&:beginning_of_day)
        expect(dates.count).to eq(2)
      end
      it 'should return zero events' do
        events = subject.timeline_days.select{|t| t.has_event?}
        expect(events.count).to eq(0)
      end
    end
  end
end
