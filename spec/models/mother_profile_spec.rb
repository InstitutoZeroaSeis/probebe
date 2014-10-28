require 'spec_helper'

RSpec.describe MotherProfile, :type => :model do
  context "without being mother or pregnant" do
    subject { build_stubbed(:mother_profile, :no_pregnant, :no_mother) }
    it { is_expected.to be_invalid }
  end

  context "being mother" do
    subject { build_stubbed(:mother_profile, :mother) }
    it { is_expected.to be_valid }
  end

  context "being pregnant" do
    subject { build_stubbed(:mother_profile, :pregnant) }
    it { is_expected.to be_valid }
  end

  context "being mother and pregnant" do
    subject { build_stubbed(:mother_profile, :mother, :pregnant) }
    it { is_expected.to be_valid }
  end

  context "without profile" do
    subject { build_stubbed(:mother_profile, :without_profile) }
    it { is_expected.to be_invalid }
  end

  context "a pregnant without children" do
    subject { build_stubbed(:mother_profile, :pregnant, :no_mother, :without_children) }
    it { is_expected.to be_valid }
  end

  context "a mother without children" do
    subject { build_stubbed(:mother_profile, :mother, :without_children) }
    it { is_expected.to be_invalid }
  end

  context "a mother with children" do
    subject { build_stubbed(:mother_profile, :mother, :with_children) }
    it { is_expected.to be_valid }
  end
end
