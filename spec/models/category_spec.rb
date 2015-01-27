require 'rails_helper'

describe Category do
  context "with no parent category" do
    subject { create(:category) }
    it { is_expected.to be_valid }
  end
end
