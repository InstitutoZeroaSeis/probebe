require 'spec_helper'

RSpec.describe Message, :type => :model do
  context "Without minimum and maximum valid week" do
    subject { build_stubbed(:message, :without_minimum_valid_week, :without_maximum_valid_week) }
    it { is_expected.to be_invalid }
  end

   context "Minimum less than maximum" do 
    subject { build_stubbed(:message, minimum_valid_week: 5, maximum_valid_week: 10 ) }
    it { is_expected.to be_valid }
  end

  context "Minimum higher than maximum" do 
    subject { build_stubbed(:message, minimum_valid_week: 12, maximum_valid_week: 10 ) }
    it { is_expected.to be_invalid }
  end
end
