require 'rails_helper'

RSpec.describe Blog::PostSearchTermFinder do
  context 'with some post' do
    it 'returns only post with expected search term' do
      search_term = 'test'
      post_with_title_with_term = create(:post, title: 'test post')
      create(:post, title: 'post without term')

      finder = Blog::PostSearchTermFinder.new(search_term, Blog::Post)

      expect(finder.find).to match_array([post_with_title_with_term])
    end

    it 'finds all posts if no term is given' do
      create_pair(:post)

      finder = Blog::PostSearchTermFinder.new(nil, Blog::Post.default_scoped)

      expect(finder.find.map(&:title))
        .to match_array(Blog::Post.all.map(&:title))
    end
  end
end
