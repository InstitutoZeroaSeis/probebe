require 'rails_helper'

RSpec.describe Blog::PostByCategoryFinder do
  it 'finds posts of the given category_name' do
    category = create(:category, :with_parent)
    post = create(:post, category: category)

    finder = Blog::PostByCategoryFinder.new(category.parent_category_id, Blog::Post.default_scoped)

    expect(finder.find.map(&:title)).to match_array([post.title])
  end

  it 'does not include unrelated posts' do
    create(:post)

    finder = Blog::PostByCategoryFinder.new(
      'missing', Blog::Post.default_scoped
    )

    expect(finder.find).to be_empty
  end

  it 'includes all posts if no category name is given' do
    relation_double = double

    finder = Blog::PostByCategoryFinder.new(nil, relation_double)

    expect(finder.find).to eq(relation_double)
  end
end
