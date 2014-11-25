require 'rails_helper'

RSpec.describe Articles::JournalisticArticleUpdater, :type => :model do
  context "updating an existing authorial article" do
    before { @authorial_article = create(:authorial_article, minimum_valid_week: 12, maximum_valid_week: 14, baby_target_type: 'pregnancy', gender: 'male', teenage_pregnancy: true, journalistic_articles: create_list(:journalistic_article, 1)) }
    before { @category = create(:category) }
    it "is expected to update value for journalisstic article" do
      attributes = {minimum_valid_week: 20, maximum_valid_week: 30, baby_target_type: 'born', gender: 'both', category_id: @category.id, teenage_pregnancy: false}
      @authorial_article.update_attributes(attributes)
      subject { Articles::JournalisticArticleUpdater @authorial_article }
      @journalistic_article = @authorial_article.journalistic_articles[0]
      expect(@journalistic_article.category_id).to eq(@authorial_article.category_id)
      expect(@journalistic_article.baby_target_type).to eq(@authorial_article.baby_target_type)
      expect(@journalistic_article.gender).to eq(@authorial_article.gender)
      expect(@journalistic_article.minimum_valid_week).to eq(@authorial_article.minimum_valid_week)
      expect(@journalistic_article.maximum_valid_week).to eq(@authorial_article.maximum_valid_week)
      expect(@journalistic_article.teenage_pregnancy).to eq(@authorial_article.teenage_pregnancy)
    end
  end
end
