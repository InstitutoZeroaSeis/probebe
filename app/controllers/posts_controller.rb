class PostsController < ApplicationController
  POSTS_PER_PAGE = 3
  layout "blog"

  def index
    @pager = build_pager Blog::PostFinder.new(params[:search], params[:category], params[:tag_name]).find
    @posts = @pager.paged
  end

  def show
    @post = Articles::JournalisticArticle.find(params[:id])
    @related_post = Blog::RelatedPostFinder.new(@post.id).find_related
    @author_profile = @post.original_author.profile
  end

  protected

  def build_pager(posts)
    page = params[:page] || 1
    Pager.new(posts, page, POSTS_PER_PAGE)
  end
end
