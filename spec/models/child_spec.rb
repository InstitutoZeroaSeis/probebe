require 'spec_helper'

RSpec.describe Child, :type => :model do
  context "born without birth date" do
    subject { build_stubbed :child, :born, :without_birth_date }
    it { is_expected.to be_invalid }
  end

  context "born with birth date" do
    subject { build_stubbed :child, :born, :with_birth_date }
    it { is_expected.to be_valid }
  end

  context "not yet born without expected birth date" do
    subject { build_stubbed :child, :not_born, :without_expected_birth_date }
    it { is_expected.to be_invalid }
  end

  context "not yet born with expected birth date" do
    subject { build_stubbed :child, :not_born, :with_expected_birth_date }
    it { is_expected.to be_valid }
  end
end
