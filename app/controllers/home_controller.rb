class HomeController < ApplicationController
  def index
    if current_user
      @categories_posts = posts_grouped_by_category
    else
      @categories = original_categories
    end
  end

  protected

  def original_categories
    Category.original_categories.map do |category|
      [category.original_category_type, category]
    end.to_h
  end

  def posts_grouped_by_category
    Blog::CategoryGroupedPostsFinder.new.find.map do |category, posts|
      [category, PostPresenter.wrap(posts)]
    end
  end
end
