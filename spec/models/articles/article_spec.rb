require 'rails_helper'

RSpec.describe Articles::Article, :type => :model do

  context "without text" do
    subject { build_stubbed :article, :without_text }
    it { is_expected.to be_invalid }
  end

  context "without title" do
    subject { build_stubbed :article, :without_title }
    it { is_expected.to be_invalid }
  end

  context "without category" do
    subject { build_stubbed :article, :without_category }
    it { is_expected.to be_invalid }
  end

  context "without user" do
    subject { build_stubbed :article, :without_user }
    it { is_expected.to be_invalid }
  end

  context "without type" do
    subject { build_stubbed :article, :without_type }
    it { is_expected.to be_invalid }
  end

  context "without minimum and maximum valid week" do
    subject { build_stubbed(:article, :without_minimum_valid_week, :without_maximum_valid_week) }
    it { is_expected.to be_invalid }
  end

   context "minimum less than maximum" do
    subject { build_stubbed(:article, minimum_valid_week: 5, maximum_valid_week: 10 ) }
    it { is_expected.to be_valid }
  end

  context "minimum higher than maximum" do
    subject { build_stubbed(:article, minimum_valid_week: 12, maximum_valid_week: 10 ) }
    it { is_expected.to be_invalid }
  end


end
