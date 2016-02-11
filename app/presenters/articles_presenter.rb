class ArticlesPresenter
  POSTS_PER_PAGE = 10
  POSTS_CONTROLLER = 'articles'

  include Rails.application.routes.url_helpers

  def initialize(article_params = {})
    @article_params = article_params
    build_pager
  end

  def articles
    @articles ||= ArticlePresenter.wrap @pager.paged
  end

  def render_next_step?
    @pager.has_next_step?
  end

  def render_previous_step?
    @pager.has_previous_step?
  end

  def previous_blog_page
    url_for(@article_params.merge(page: current_page + 1, controller: POSTS_CONTROLLER))
  end

  def next_blog_page
    url_for(@article_params.merge(page: current_page - 1, controller: POSTS_CONTROLLER))
  end

  def tags_for_sidebar
    Tag.joins(:articles).
      select('tags.id, tags.name, COUNT(*) as articles_count').
      group('tags.id').
      order('tags.name ASC, articles_count DESC')
  end

  def categories_for_sidebar
    Category.base_categories.
      where(blog_section: false)
  end

  protected

  def current_page
    page = @article_params[:page]
    page ? page.to_i : 1
  end

  def build_pager
    articles = Site::ArticleFinder.new(@article_params).find
    @pager = Pager.new(articles, current_page, POSTS_PER_PAGE)
  end
end
