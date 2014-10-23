require 'spec_helper'

describe Category do
  context "with no parent category" do
    subject { create(:category) }
    it { is_expected.to be_valid }
  end

  context "with hierarchy greater than 2" do
    subject { build(:category, parent_category: create(:category, :with_parent)) }
    it { is_expected.to be_invalid }
  end

  context "With parent category equals to self" do
    subject { build(:category, :with_parent_category_same_as_self) }
    it { is_expected.to be_invalid }
  end

  context "Having children" do
    subject { build(:category, :with_children) }
    it "Should not be destroyed" do
      subject.destroy
      expect(subject.destroyed?).to eq(false)
    end
  end
end