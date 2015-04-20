class HomeController < ApplicationController
  layout 'blog'

  def index
    @categories_articles = CategorySampleArticlesDecorator.group_by_parent_category if current_user
  end

end
