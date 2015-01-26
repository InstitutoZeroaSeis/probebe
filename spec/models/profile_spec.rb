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

  it "is expected to set the name attribute when creating" do
    profile = build_stubbed(:profile)
    profile.run_callbacks(:save)
    expect(profile.name).to eq("#{profile.first_name} #{profile.last_name}")
  end

  it "is expected to update the name attribute when being updated" do
    profile = build_stubbed(:profile)
    profile.first_name = "Fname"
    profile.last_name = "Lname"
    profile.run_callbacks(:save)
    expect(profile.name).to eq("Fname Lname")
  end
end
