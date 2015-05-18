require 'rails_helper'

RSpec.describe Blog::PostByTagFinder do
  context 'with some post' do
    it 'returns only post with expected tag' do
      tag = create(:tag)
      post_with_tag = create(:post, tags: [tag])
      post_with_another_tag = create(:post)

      finder = Blog::PostByTagFinder.new(tag.id, Blog::Post)

      expect(finder.find).to eq([post_with_tag])
    end
  end
end
