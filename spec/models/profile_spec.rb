require 'rails_helper'

RSpec.describe Profile, :type => :model do

  context "without first name" do
    subject { build_stubbed(:profile, first_name: "") }
    it { is_expected.to be_invalid }
  end

  context "without last name" do
    subject { build_stubbed(:profile, last_name: "") }
    it { is_expected.to be_invalid }
  end

  context "without user" do
    subject { build_stubbed(:profile, user: nil) }
    it { is_expected.to be_invalid }
  end
end
