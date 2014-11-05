require 'rails_helper'

RSpec.describe Tag, :type => :model do

  context "Without name" do
    subject { build_stubbed(:tag, :without_name) }
    it { is_expected.to be_invalid }
  end

  context "Two tags with the same name" do
    before { @tag = create(:tag) }
    subject { build_stubbed(:tag, name: @tag.name) }
    it { is_expected.to be_invalid }
  end
end
