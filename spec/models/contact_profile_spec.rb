require 'spec_helper'

RSpec.describe ContactProfile, :type => :model do
  context "Without smartphone or dumpphone" do
    subject { build_stubbed(:contact_profile, :with_residential_phone) }
    it { is_expected.to be_invalid }
  end

  context "With smartphone" do
    subject { build_stubbed(:contact_profile, :with_smartphone) }
    it { is_expected.to be_valid }
  end

  context "With dumpphone" do
    subject { build_stubbed(:contact_profile, :with_dumpphone) }
    it { is_expected.to be_valid }
  end
end
