require 'rails_helper'

RSpec.describe Articles::JournalisticArticleUpdater, type: :model do
  context 'updating an existing authorial article' do
    it 'is expected to update value for journalisstic article' do
      authorial_article = create(:authorial_article, journalistic_articles: [
        create(:journalistic_article)
      ])
      category = create(:category, :with_parent)
      attributes = {
        minimum_valid_week: 20, maximum_valid_week: 30,
        baby_target_type: 'born', gender: 'both',
        category_id: category.id, teenage_pregnancy: false
      }

      authorial_article.update_attributes(attributes)

      journalistic_article = authorial_article.journalistic_articles.first
      Articles::JournalisticArticleUpdater::PROPERTIES.each do |property|
        expect(journalistic_article.send(property))
          .to eq(authorial_article.send(property))
      end
    end
  end
end
