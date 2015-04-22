require 'rails_helper'

RSpec.describe Blog::PostPublishableFinder do
  context 'with some posts' do
    it 'returns only publishable posts' do
      published_post = create(:post, :published)
      unpublished_post = create(:post, :unpublished)

      finder = Blog::PostPublishableFinder.new(Blog::Post)
      expect(finder.find).to eq([published_post])
    end
  end
end
