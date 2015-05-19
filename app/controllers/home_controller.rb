class HomeController < ApplicationController
  def index
    if current_user
      @categories_posts = posts_grouped_by_category.map do |category, posts|
        [category, PostPresenter.wrap(posts)]
      end
    else
      @categories = Category.original_categories.map do |category|
        [category.original_category_type, category]
      end.to_h
    end
  end

  protected

  def posts_grouped_by_category
    CategorySampleArticlesDecorator.group_by_parent_category
  end
end
