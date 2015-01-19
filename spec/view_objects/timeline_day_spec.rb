require 'rails_helper'

RSpec.describe TimelineDay do
  describe ".has_event?" do
    context 'without event' do
      subject { TimelineDay.new(Date.today, nil) }
      its(:has_event?) { should eq(false) }
    end

    context 'with event' do
      subject { TimelineDay.new(Date.today, Object.new) }
      its(:has_event?) { should eq(true) }
    end
  end

  describe ".event_content" do
    context 'given an event' do
     let(:event) { instance_double("Event", text: "Event text") }
     subject { TimelineDay.new(Date.today, event) }
     its(:event_content) { should eq(event.text) }
    end
  end

  describe ".to_partial_path" do
    subject { TimelineDay.new(Date.today, Object.new) }
    its(:to_partial_path) { should eq("timelines/timeline_day") }
  end
end
