require 'rails_helper'

RSpec.describe Articles::JournalisticArticleFactory, :type => :model do
  context "creating a journalistic article from an authorial article" do
    let(:authorial_article) { create(:authorial_article) }
    subject { Articles::JournalisticArticleFactory.from_authorial_article authorial_article }

    its(:category_id) { should eq(authorial_article.category_id) }
    its(:baby_target_type) { should eq(authorial_article.baby_target_type) }
    its(:gender) { should eq(authorial_article.gender) }
    its(:minimum_valid_week) { should eq(authorial_article.minimum_valid_week) }
    its(:maximum_valid_week) { should eq(authorial_article.maximum_valid_week) }
    its(:teenage_pregnancy) { should eq(authorial_article.teenage_pregnancy) }
    its(:tags) { should match_array(authorial_article.tags) }
  end
end
