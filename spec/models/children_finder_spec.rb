require 'rails_helper'

RSpec.describe ChildrenFinder, :type => :model do

  context "with a message targeting born, males until 24 months" do
    context "and with a born, male and half an year old" do
      subject { ChildrenFinder.new(@message, Child.all).find_childrens_for_message }
      before { @child = create(:child, birth_date: 18.months.ago) }
      before { @message = create(:message, :male, maximum_valid_week: 24 * 7, baby_target_type: 'born') }
      it { is_expected.to match_array([@child]) }
    end
  end

  context "with a message targeting born children, male that are between 1 and 2 years old" do
    context "and with a male baby about 18 months old and another baby, female about 14 months old" do
      subject { ChildrenFinder.new(@message, Child.all).find_childrens_for_message }
      before { @male = create(:child, :male, birth_date: (18.months).ago) }
      before { @female =  create(:child, :female, birth_date: (14.months).ago) }
      before { @message = create(:message, :male, minimum_valid_week: 52, maximum_valid_week: 104, baby_target_type: 'born') }
      it { is_expected.to match_array([@male]) }
    end
  end

end
