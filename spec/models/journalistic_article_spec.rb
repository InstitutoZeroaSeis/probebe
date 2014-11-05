require 'rails_helper'

RSpec.describe Articles::JournalisticArticle, :type => :model do

  context "With parent authorial article" do
    subject { build_stubbed :journalistic_article, :with_parent_authorial_article }
    it { is_expected.to be_valid }
  end

  context "Without parent article" do
    subject { build_stubbed :journalistic_article, :without_parent_article }
    it { is_expected.to be_invalid }
  end


end
