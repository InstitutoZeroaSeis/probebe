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
      before { create(:child, :not_born, pregnancy_start_date: 22.weeks.ago) }
      before { create(:child, :not_born, pregnancy_start_date: 28.weeks.ago) }
      before { create(:message, :male, minimum_valid_week: 20, maximum_valid_week: 30, baby_target_type: 'pregnancy') }
      it { is_expected.to match_array([MessageDelivery.new(Message.first, Child.all)]) }
    end
  end

  context "with a message targeting born children, male that are between 1 and 2 years old" do
    context "and with a male baby about 18 months old and another baby, female about 14 months old" do
      subject { MessageSender.new.send_messages }
      before { @male = create(:child, :male, :born, birth_date: (18.months).ago) }
      before { create(:child, :female, :born, birth_date: (14.months).ago) }
      before { create(:message, :male, minimum_valid_week: 52, maximum_valid_week: 104, baby_target_type: 'born') }
      it { is_expected.to match_array([MessageDelivery.new(Message.first, [@male])]) }
    end
  end
end
