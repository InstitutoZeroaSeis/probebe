require 'rails_helper'

RSpec.describe Site::ArticleOrderByCreation do
  context 'with some posts' do
    it 'returns ordered by newest' do
      two_days_ago_post = create(:post, created_at: 2.days.ago)
      today_post = create(:post, created_at: Date.today)
      yesterday_post = create(:post, created_at: 1.day.ago)
      ordered_posts = [today_post, yesterday_post, two_days_ago_post]

      finder = Site::ArticleOrderByCreation.new(Site::Article)

      expect(finder.sort.map(&:title))
        .to eq(ordered_posts.map(&:title))
    end
  end
end
