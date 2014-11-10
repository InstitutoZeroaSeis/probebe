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


end
