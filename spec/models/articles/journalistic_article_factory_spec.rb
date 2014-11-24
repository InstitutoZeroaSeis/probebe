require 'rails_helper'

RSpec.describe Articles::JournalisticArticleFactory, :type => :model do
  context "given an existing authorial_article" do
    let(:authorial_article) { create(:authorial_article) }
    subject { Articles::JournalisticArticleFactory.from_authorial_article authorial_article }
    it "is expected to create a new journalistic article initialized with the authorial article attributes" do
      expect(subject.category_id).to eq(authorial_article.category_id)
      expect(subject.baby_target_type).to eq(authorial_article.baby_target_type)
      expect(subject.gender).to eq(authorial_article.gender)
      expect(subject.minimum_valid_week).to eq(authorial_article.minimum_valid_week)
      expect(subject.maximum_valid_week).to eq(authorial_article.maximum_valid_week)
      expect(subject.teenage_pregnancy).to eq(authorial_article.teenage_pregnancy)
      expect(subject.tags).to match_array(authorial_article.tags)
    end
  end
end
