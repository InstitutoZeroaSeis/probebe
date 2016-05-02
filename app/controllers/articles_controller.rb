class ArticlesController < ApplicationController
  def index
    @presenter = ArticlesPresenter.new(post_search_params, params[:order], current_user)
  end

  def show
    @article = ArticlePresenter.new(Site::Article.friendly.find(params[:id]))
    render layout: 'single-post'
  end

  def raw
    @article = ArticlePresenter.new(Site::Article.friendly.find(params[:id]))
    render layout: 'raw-single-post'
  end

  protected

  def post_search_params
    params.slice(:search, :category_id, :tag_name, :life_period, :page, :author_id)
  end
end
