require 'rails_helper'

RSpec.describe ProfileFinder, :type => :model do

  context "with two mothers both with children with about 15 weeks of pregnancy" do
    context "and with a article targeting childrens up to 20 weeks of pregnancy" do
      subject { ProfileFinder.new(@article).find_profiles_by_article }
      before { @article = create(:article, maximum_valid_week: 20, baby_target_type: 'pregnancy') }
      before { @mother1 = create(:profile, children: create_list(:child, 2, birth_date: (Child::PREGNANCY_DURATION_IN_WEEKS - 15).weeks.from_now)) }
      before { @mother2 = create(:profile, children: create_list(:child, 2, birth_date: (Child::PREGNANCY_DURATION_IN_WEEKS - 15).weeks.from_now)) }
      it { is_expected.to match_array([@mother1, @mother2]) }
    end
  end

  context "with two mothers one with a male and born children half an year old and the other with a male 1 year old children" do
    context "and with a article targeting born childrens up to six months of life" do
      subject { ProfileFinder.new(@article).find_profiles_by_article }
      before { @article = create(:article, minimum_valid_week: 0, maximum_valid_week: 6, baby_target_type: 'born') }
      before { create(:profile, children: create_list(:child, 1, birth_date: 12.weeks.ago)) }
      before { @mother = create(:profile, children: create_list(:child, 1, birth_date: 6.weeks.ago)) }
      it { is_expected.to match_array([@mother]) }
    end
  end

  context "with a article targeting not yet born children, regardless the gender that are between 20 and 30 weeks of gestation" do
    context "and with a mother with a gestation of 22 weeks and the other with 28 weeks" do
      subject { ProfileFinder.new(@article).find_profiles_by_article }
      before { @profile = create(:profile, children: create_list(:child, 1, birth_date: (Child::PREGNANCY_DURATION_IN_WEEKS - 22).weeks.from_now)) }
      before { @profile2 = create(:profile, children: create_list(:child, 1, birth_date: (Child::PREGNANCY_DURATION_IN_WEEKS - 28).weeks.from_now)) }
      before { @article = create(:article, :male, minimum_valid_week: 20, maximum_valid_week: 30, baby_target_type: 'pregnancy') }
      it { is_expected.to match_array([@profile, @profile2]) }
    end
  end

  context "with a article targeting not yet born children, that are up to 12 weeks of gestation" do
    context "and with two not yet born children, both with 15 weeks of gestation period" do
      subject { ProfileFinder.new(@article).find_profiles_by_article }
      before { create_list(:profile, 2, children: create_list(:child, 1, birth_date: (Child::PREGNANCY_DURATION_IN_WEEKS - 15).weeks.ago)) }
      before { @article = create(:article, maximum_valid_week: 12, baby_target_type: 'pregnancy') }
      it { is_expected.to match_array([]) }
    end
  end
end
