class PostsController < ApplicationController
  POSTS_PER_PAGE = 3
  layout "blog"

  def index
    @pager = build_pager Articles::JournalisticArticle.ordered_by_creation_date
      .publishable
      .by_tag(params[:tag_id])
      .by_category(params[:category_id])
      .by_search_term(params[:search])
      .journalistic

    @posts = @pager.paged
  end

  def show
    @post = Articles::JournalisticArticle.find(params[:id])
  end

  protected

  def build_pager(posts)
    page = params[:page] || 1
    Pager.new(posts, page, POSTS_PER_PAGE)
  end
end
