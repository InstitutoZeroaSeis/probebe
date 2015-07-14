require 'rails_helper'

RSpec.describe Site::ArticleByCategoryFinder do
  it 'finds posts of the given category_name' do
    category = create(:category, :with_parent)
    post = create(:post, category: category)

    finder = Site::ArticleByCategoryFinder.new(category.parent_category_id, Site::Article.default_scoped)

    expect(finder.find.map(&:title)).to match_array([post.title])
  end

  it 'does not include unrelated posts' do
    create(:post)

    finder = Site::ArticleByCategoryFinder.new(
      'missing', Site::Article.default_scoped
    )

    expect(finder.find).to be_empty
  end

  it 'includes all posts if no category name is given' do
    relation_double = double

    finder = Site::ArticleByCategoryFinder.new(nil, relation_double)

    expect(finder.find).to eq(relation_double)
  end
end
