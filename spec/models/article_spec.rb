require 'rails_helper'

RSpec.describe Articles::Article, :type => :model do

  context "Without text" do
    subject { build_stubbed :article, :without_text }
    it { is_expected.to be_invalid }
  end

  context "Without category" do 
    subject { build_stubbed :article, :without_category }
    it { is_expected.to be_invalid }
  end

  context "Without user" do 
    subject { build_stubbed :article, :without_user }
    it { is_expected.to be_invalid }
  end

  context "Without type" do 
    subject { build_stubbed :article, :without_type }
    it { is_expected.to be_invalid }
  end


end
