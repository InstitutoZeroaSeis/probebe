require 'rails_helper'

RSpec.describe Site::ArticleSearchTermFinder do
  context 'with some post' do
    it 'returns only post with expected search term' do
      search_term = 'test'
      post_with_title_with_term = create(:post, title: 'test post')
      create(:post, title: 'post without term')

      finder = Site::ArticleSearchTermFinder.new(search_term, Site::Article)

      expect(finder.find).to match_array([post_with_title_with_term])
    end

    it 'finds all posts if no term is given' do
      create_pair(:post)

      finder = Site::ArticleSearchTermFinder.new(nil, Site::Article.default_scoped)

      expect(finder.find.map(&:title))
        .to match_array(Site::Article.all.map(&:title))
    end
  end
end
