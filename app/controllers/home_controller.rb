class HomeController < ApplicationController
  def index
    return unless current_user
    @categories_posts = posts_grouped_by_category.map do |category, posts|
      [category, PostPresenter.wrap(posts)]
    end
  end

  protected

  def posts_grouped_by_category
    CategorySampleArticlesDecorator.group_by_parent_category
  end
end
