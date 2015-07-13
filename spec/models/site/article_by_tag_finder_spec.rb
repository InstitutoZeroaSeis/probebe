require 'rails_helper'

RSpec.describe Site::ArticleByTagFinder do
  context 'with some post' do
    it 'returns only post with expected tag' do
      tag = create(:tag)
      post_with_tag = create(:post, tags: [tag])
      post_with_another_tag = create(:post)

      finder = Site::ArticleByTagFinder.new(tag.id, Site::Article)

      expect(finder.find).to eq([post_with_tag])
    end
  end
end
