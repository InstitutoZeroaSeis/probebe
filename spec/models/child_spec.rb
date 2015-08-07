require 'rails_helper'

RSpec.describe Child, :type => :model do
  context "without birth date" do
    subject { build_stubbed :child, :without_birth_date }
    it { is_expected.to be_invalid }
  end

  context "with birth date" do
    subject { build_stubbed :child, :with_birth_date }
    it { is_expected.to be_valid }
  end

  context "with a baby that probably will born twelve weeks from now" do
    subject { build_stubbed(:child, birth_date: 12.weeks.from_now).age_in_weeks(@system_date) }
    before {@system_date = MessageDeliveries::SystemDate.new}
    it { is_expected.to eq(30) }
  end

  context "with a baby that probably will born twenty five weeks from now" do
    subject { build_stubbed(:child, birth_date: 25.weeks.from_now).age_in_weeks(@system_date) }
    before {@system_date = MessageDeliveries::SystemDate.new}
    it { is_expected.to eq(17) }
  end

  context "with a baby that will born more than 42 weeks from now" do
    subject { build_stubbed :child, birth_date: 43.weeks.from_now }
    it { is_expected.to be_invalid }
  end

  context "with a baby that will born less than 42 weeks from now" do
    subject { build_stubbed :child, birth_date: 41.weeks.from_now }
    it { is_expected.to be_valid }
  end

  context 'with donor' do
    it 'is invalid with profile_type == donor' do
      profile1 = Profile.new profile_type: :donor
      profile2 = Profile.new profile_type: :donor
      child = build :child, profile: profile2, donor: profile1

      child.valid?

      expect(child.errors[:donor])
        .to include('A mãe ja é uma doadora.')
    end

  end
end
