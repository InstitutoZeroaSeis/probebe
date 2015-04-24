class PostsPresenter
  POSTS_PER_PAGE = 4
  POSTS_CONTROLLER = 'posts'

  include Rails.application.routes.url_helpers

  def initialize(post_params = {})
    @post_params = post_params
    build_pager
  end

  def posts
    @posts ||= PostPresenter.wrap @pager.paged
  end

  def render_next_step?
    @pager.has_next_step?
  end

  def render_previous_step?
    @pager.has_previous_step?
  end

  def previous_blog_page
    url_for(@post_params.merge(page: current_page + 1, controller: POSTS_CONTROLLER))
  end

  def next_blog_page
    url_for(@post_params.merge(page: current_page - 1, controller: POSTS_CONTROLLER))
  end

  def tags
    Tag.all
  end

  protected

  def current_page
    page = @post_params[:page]
    page ? page.to_i : 1
  end

  def build_pager
    posts = Blog::PostFinder.new(@post_params).find
    @pager = Pager.new(posts, current_page, POSTS_PER_PAGE)
  end
end
