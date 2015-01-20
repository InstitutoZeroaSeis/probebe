require 'rails_helper'

RSpec.describe TimelineStep, :type => :model do
  describe ".next_step" do
    subject{ TimelineStep.new 3 }

    it "is expected to return numbers in an increasing order starting from 1" do
      returned_steps = [subject.next_step, subject.next_step, subject.next_step]
      expect(["01", "02", "03"]).to eq(returned_steps)
    end

    it "is expected to cycle the given steps" do
      subject.next_step
      subject.next_step
      subject.next_step

      expect("01").to eq(subject.next_step)
    end
  end
end
