class HomeController < ApplicationController
  def index
    @source = get_source
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

  def get_source
    return params[:utm_source] if params[:utm_source].present?
    URI(request.referer).path if request.referer.present?
    ''
  end
end
