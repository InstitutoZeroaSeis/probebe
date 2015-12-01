class HomeController < ApplicationController
  def index
    if current_user
      @categories_articles = articles_grouped_by_category
    else
      @categories = Category.to_show_in_home
    end
  end

  protected

  def articles_grouped_by_category
    Site::CategoryGroupedArticlesFinder.new.find.map do |category, articles|
      [category, ArticlePresenter.wrap(articles)]
    end
  end


end
