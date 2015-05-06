require 'rails_helper'

RSpec.describe Blog::PostByCategoryFinder do
  it 'finds posts of the given category_name' do
    health_category = create(:category, name: 'health')
    education_category = create(:category)
    health_post = create(:post, category: health_category)
    create(:post, category: education_category)

    finder = Blog::PostByCategoryFinder.new('health', Blog::Post.default_scoped)

    expect(finder.find).to eq([health_post])
  end

  it 'does not include unrelated posts' do
    create(:post)

    finder = Blog::PostByCategoryFinder.new(
      'missing', Blog::Post.default_scoped
    )

    expect(finder.find).to be_empty
  end

  it 'includes all posts if no category name is given' do
    posts = create_pair(:post)

    finder = Blog::PostByCategoryFinder.new(nil, Blog::Post.default_scoped)

    expect(finder.find).to match_array(posts)
  end
end
