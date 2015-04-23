class PostsController < ApplicationController
  POSTS_PER_PAGE = 3
  # layout "blog"

  def index
    @pager = build_pager Blog::PostFinder.new(params_to_finder).find
    @posts = @pager.paged
  end

  def show
    @post = Blog::Post.find(params[:id])
    @related_post = Blog::RelatedPostFinder.new(@post.id).find_related
    @author_profile = @post.original_author.profile
  end

  protected

  def build_pager(posts)
    page = params[:page] || 1
    Pager.new(posts, page, POSTS_PER_PAGE)
  end

  def params_to_finder
    {
      search: params[:search],
      category: params[:category],
      tag_name: params[:tag_name]
    }
  end
end
