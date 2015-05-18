require 'rails_helper'

RSpec.describe Blog::RelatedPostFinder do
  context 'with related posts' do
    it 'returns only related posts' do
      tag = create(:tag)
      related_posts = create_pair(:post, tags: [tag])
      post = create(:post, tags: [tag])

      finder = Blog::RelatedPostFinder.new(post.id)

      expect(finder.find_related.map(&:title))
        .to match_array(related_posts.map(&:title))
    end

    it 'does not include unrelated posts' do
      unrelated_post = create(:post)
      post = create(:post, tags: [create(:tag)])

      finder = Blog::RelatedPostFinder.new(post.id)

      expect(finder.find_related.map(&:title))
        .to_not include(unrelated_post.title)
    end

    it 'does not list the post itself as related' do
      post = create(:post, tags: [create(:tag)])

      finder = Blog::RelatedPostFinder.new(post.id)

      expect(finder.find_related).to be_empty
    end
  end
end
