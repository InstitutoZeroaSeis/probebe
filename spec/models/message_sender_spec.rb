require 'spec_helper'

RSpec.describe MessageSender, :type => :model do

  context "with a message targeting born, males until 24 weeks" do
    context "and with a born, male and half an year old child" do
      subject { MessageSender.new.send_messages }
      before { create(:child, :born, birth_date: 24.weeks.ago) }
      before { create(:message, :male, maximum_valid_week: 24, baby_target_type: 'born') }
      it { is_expected.to match_array([MessageDelivery.new(Message.first, [Child.first])]) }
    end
  end

  context "with a message targeting not yet born children, regardless the gender that are between 20 and 30 weeks of gestation" do
    context "and with a baby with the gender not yet know with 22 weeks of gestation period and the other too unknown gender with 28 weeks of gestation period" do
      subject { MessageSender.new.send_messages }
      before { create(:child, :born, birth_date: 22.weeks.ago) }
      before { create(:child, :born, birth_date: 28.weeks.ago) }
      before { create(:message, :male, minimum_valid_week: 20, maximum_valid_week: 30, baby_target_type: 'born') }
      it { is_expected.to match_array([MessageDelivery.new(Message.first, Child.all)]) }
    end
  end
end
