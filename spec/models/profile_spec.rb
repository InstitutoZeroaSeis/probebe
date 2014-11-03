require 'rails_helper'

RSpec.describe Profile, :type => :model do
  context "Without cell phone" do
    subject { build_stubbed(:profile, :without_cell_phone) }
    it { is_expected.to be_invalid }
  end

  context "With cell phone" do
    subject { build_stubbed(:profile, :with_cell_phone) }
    it { is_expected.to be_valid }
  end

  context "without being mother or pregnant" do
    subject { build_stubbed(:profile, :no_pregnant, :no_mother) }
    it { is_expected.to be_invalid }
  end

  context "being mother" do
    subject { build_stubbed(:profile, :mother) }
    it { is_expected.to be_valid }
  end

  context "being pregnant" do
    subject { build_stubbed(:profile, :pregnant) }
    it { is_expected.to be_valid }
  end

  context "being mother and pregnant" do
    subject { build_stubbed(:profile, :mother, :pregnant) }
    it { is_expected.to be_valid }
  end

  context "without children" do
    subject { build_stubbed(:profile, :mother, :without_children) }
    it { is_expected.to be_invalid }
  end
end
