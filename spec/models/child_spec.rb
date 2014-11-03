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

end
