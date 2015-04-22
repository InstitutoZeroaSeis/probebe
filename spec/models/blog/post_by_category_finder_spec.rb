require 'rails_helper'

RSpec.describe Blog::PostByCategoryFinder do
  context 'with some post' do
    it 'returns only post with expected category' do
      health_category = create(:category, :with_health_parent)
      education_category = create(:category, :with_education_parent)
      health_post = create(:post, category: health_category)
      education_post = create(:post, category: education_category)

      finder = Blog::PostByCategoryFinder.new('health', Blog::Post)

      expect(finder.find).to eq([health_post])
    end
  end
end
