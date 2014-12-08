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

end
