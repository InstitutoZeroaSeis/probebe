require 'rails_helper'

RSpec.describe Message, :type => :model do
  context "without minimum and maximum valid week" do
    subject { build_stubbed(:message, :without_minimum_valid_week, :without_maximum_valid_week) }
    it { is_expected.to be_invalid }
  end

   context "minimum less than maximum" do
    subject { build_stubbed(:message, minimum_valid_week: 5, maximum_valid_week: 10 ) }
    it { is_expected.to be_valid }
  end

  context "minimum higher than maximum" do 
    subject { build_stubbed(:message, minimum_valid_week: 12, maximum_valid_week: 10 ) }
    it { is_expected.to be_invalid }
  end
end
