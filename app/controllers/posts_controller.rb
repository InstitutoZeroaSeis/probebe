class PostsController < ApplicationController
  POSTS_PER_PAGE = 10
  layout "blog"

  def index
    @posts = Articles::JournalisticArticle.default_scoped
    sort_posts
    filter_posts
    build_pager(@posts)
    @posts = @pager.paged
  end

  def show
    @post = Articles::JournalisticArticle.find(params[:id])
  end

  private

  def sort_posts
    @posts = @posts.order(created_at: :desc)
  end

  def filter_posts
    if params[:category_id]
      @posts = @posts.where(category_id: params[:category_id])
    end
    if params[:tag_id]
      @posts = @posts.includes(:tags).where(tags: { id: params[:tag_id] })
    end
  end

  def build_pager(articles)
    page = params[:page] || 1
    @pager = Pager.new(articles, page, POSTS_PER_PAGE)
  end
end
