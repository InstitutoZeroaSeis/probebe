require 'rails_helper'

RSpec.describe ProfileFinder, :type => :model do

  context "with two mothers both with children with about 15 weeks of pregnancy" do
    context "and with a message targeting childrens up to 20 weeks of pregnancy" do
      subject { ProfileFinder.new(@message).find_profiles_by_message }
      before { @message = create(:message, maximum_valid_week: 20, baby_target_type: 'pregnancy') }
      before { @mother1 = create(:profile, children: create_list(:child, 2)) }
      before { @mother2 = create(:profile, children: create_list(:child, 2)) }
      it { is_expected.to match_array([@mother1, @mother2]) }
    end
  end

  context "with two mothers one with a male and born children half an year old and the other with a male 1 year old children" do
    context "and with a message targeting born childrens up to six months of life" do
      subject { ProfileFinder.new(@message).find_profiles_by_message }
      before { @message = create(:message, maximum_valid_week: 6, baby_target_type: 'born') }
      before { create(:profile, children: create_list(:child, 1, birth_date: 12.weeks.ago)) }
      before { @mother = create(:profile, children: create_list(:child, 1, birth_date: 6.weeks.ago)) }
      it { is_expected.to match_array([@mother]) }
    end
  end

  context "with a message targeting not yet born children, regardless the gender that are between 20 and 30 weeks of gestation" do
    context "and with a mother with a gestation of 22 weeks and the other with 28 weeks" do
      subject { ProfileFinder.new(@message).find_profiles_by_message }
      before { @profile = create(:profile, pregnancy_start_date: 22.weeks.ago) }
      before { @profile2 = create(:profile, pregnancy_start_date: 28.weeks.ago) }
      before { @message = create(:message, :male, minimum_valid_week: 20, maximum_valid_week: 30, baby_target_type: 'pregnancy') }
      it { is_expected.to match_array([@profile, @profile2]) }
    end
  end

  context "with a message targeting not yet born children, that are up to 12 weeks of gestation" do
    context "and with two not yet born children, both with 15 weeks of gestation period" do
      subject { ProfileFinder.new(@message).find_profiles_by_message }
      before { create_list(:profile, 2, pregnancy_start_date: 15.weeks.ago) }
      before { @message = create(:message, maximum_valid_week: 12, baby_target_type: 'pregnancy') }
      it { is_expected.to match_array([]) }
    end
  end
end
