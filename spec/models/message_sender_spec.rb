require 'spec_helper'

RSpec.describe MessageSender, :type => :model do

  context "with a born, male and half an year old child" do
    subject { MessageSender.new.send_messages }
    before { create(:child, :born, birth_date: 24.weeks.ago) }
    before { create(:message, :male, maximum_valid_week: 24, baby_target_type: 'born') }
    it { is_expected.to match_array([MessageDelivery.new(Message.first, [Child.first])]) }
  end

end
