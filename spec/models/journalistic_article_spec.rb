require 'rails_helper'

RSpec.describe Articles::JournalisticArticle, :type => :model do

  context "with parent authorial article" do
    subject { build_stubbed :journalistic_article, :with_parent_authorial_article }
    it { is_expected.to be_valid }
  end

  context "without parent article" do
    subject { build_stubbed :journalistic_article, :without_parent_article }
    it { is_expected.to be_invalid }
  end

  context "without original author" do
    subject { build_stubbed :journalistic_article, :without_original_author }
    it { is_expected.to be_invalid }
  end

  context "with a message greater than 150 characters" do
    subject { build_stubbed :journalistic_article, messages: create_list(:message, 1, text: 'a' * 151)}
    it { is_expected.to be_invalid }
  end

  context "with a message smaller than 150 characters" do
    subject { build_stubbed :journalistic_article, messages: create_list(:message, 1, text: 'a' * 149)}
    it { is_expected.to be_valid }
  end

end
