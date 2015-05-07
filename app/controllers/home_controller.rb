class HomeController < ApplicationController
  def index
    return unless current_user
    @categories_articles =
      CategorySampleArticlesDecorator.group_by_parent_category
  end
end
