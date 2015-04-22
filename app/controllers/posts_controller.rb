class PostsController < ApplicationController
  POSTS_PER_PAGE = 3
  layout "blog"

  def index
    ordered_post = Blog::PostOrderByCreation.new(Blog::Post.all).sort
    publishable_post = Blog::PostPublishableFinder.new(ordered_post).find
    post_by_search_name = Blog::PostSearchTermFinder.new(params[:search], publishable_post).find
    post_by_category = Blog::PostByCategoryFinder.new(params[:category], post_by_search_name).find
    post_by_tag = Blog::PostByTagFinder.new(params[:tag_name], post_by_category).find
    @pager = build_pager post_by_tag
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
