require 'spec_helper'

RSpec.describe ChildrenFinder, :type => :model do

  context "with a message targeting born, males until 24 weeks" do
    context "and with a born, male and half an year old child" do
      subject { ChildrenFinder.new(@message, Child.all).find_childrens_for_message }
      before { @child = create(:child, :born, birth_date: 24.weeks.ago) }
      before { @message = create(:message, :male, maximum_valid_week: 24, baby_target_type: 'born') }
      it { is_expected.to match_array([@child]) }
    end
  end

  context "with a message targeting not yet born children, regardless the gender that are between 20 and 30 weeks of gestation" do
    context "and with a baby with the gender not yet know with 22 weeks of gestation period and the other too unknown gender with 28 weeks of gestation period" do
      subject { ChildrenFinder.new(@message, Child.all).find_childrens_for_message }
      before { @child = create(:child, :not_born, pregnancy_start_date: 22.weeks.ago) }
      before { @child2 = create(:child, :not_born, pregnancy_start_date: 28.weeks.ago) }
      before { @message = create(:message, :male, minimum_valid_week: 20, maximum_valid_week: 30, baby_target_type: 'pregnancy') }
      it { is_expected.to match_array([@child, @child2]) }
    end
  end

  context "with a message targeting born children, male that are between 1 and 2 years old" do
    context "and with a male baby about 18 months old and another baby, female about 14 months old" do
      subject { ChildrenFinder.new(@message, Child.all).find_childrens_for_message }
      before { @male = create(:child, :male, :born, birth_date: (18.months).ago) }
      before { @female =  create(:child, :female, :born, birth_date: (14.months).ago) }
      before { @message = create(:message, :male, minimum_valid_week: 52, maximum_valid_week: 104, baby_target_type: 'born') }
      it { is_expected.to match_array([@male]) }
    end
  end

  context "with a message targeting not yet born children, that are up to 12 weeks of gestation" do
    context "and with two not yet born children, both with 15 weeks of gestation period" do
      subject { ChildrenFinder.new(@message, Child.all).find_childrens_for_message }
      before { create_list(:child, 2, :not_born, pregnancy_start_date: 15.weeks.ago) }
      before { @message = create(:message, maximum_valid_week: 12, baby_target_type: 'pregnancy') }
      it { is_expected.to match_array([]) }
    end
  end

end