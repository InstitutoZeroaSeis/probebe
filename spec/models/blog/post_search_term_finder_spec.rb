require 'rails_helper'

RSpec.describe Blog::PostSearchTermFinder do
  context 'with some post' do
    it 'returns only post with expected search term' do
      search_term = 'test'
      post_with_title_with_term = create(:post, title: 'test post')
      post_with_title_without_term = create(:post, title: 'post without term')

      finder = Blog::PostSearchTermFinder.new(search_term, Blog::Post)

      expect(finder.find).to eq([post_with_title_with_term])
    end
  end
end
