class PostsController < ApplicationController
  POSTS_PER_PAGE = 10
  layout "blog"

  def index
    build_pager
    @posts = @pager.paged
  end

  def show
    @post = Articles::JournalisticArticle.find(params[:id])
  end

  private

  def build_pager
    page = params[:page] || 1
    @pager = Pager.new(Articles::JournalisticArticle.order(created_at: :desc), page, POSTS_PER_PAGE)
  end
end
