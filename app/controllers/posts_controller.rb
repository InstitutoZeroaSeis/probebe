class PostsController < ApplicationController
  POSTS_PER_PAGE = 5
  layout "blog"

  def index
    @pager = build_pager Articles::JournalisticArticle.ordered_by_creation_date
      .publishable
      .by_tag(params[:tag_name])
      .by_search_term(params[:search])
      .by_category(params[:category])
      .journalistic

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
