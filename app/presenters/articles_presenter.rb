class ArticlesPresenter
  POSTS_PER_PAGE = 10
  POSTS_CONTROLLER = 'articles'

  include Rails.application.routes.url_helpers

  def initialize(article_params = {}, order)
    @article_params = article_params
    @article_params[:search] = ActiveSupport::Inflector.transliterate(article_params[:search])
    @order = order
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
    raw_order = 'tags.name ASC, articles_count DESC'
    raw_order = 'articles_count DESC' if @order == 'quantity'

    Tag.joins(:articles).
      select('tags.id, tags.name, COUNT(*) as articles_count').
      group('tags.id').
      order(raw_order)
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

  def articles_from_elasticsearch
    Articles::Article.search(@article_params[:search]).page(current_page).records.to_a
      .select { |a| a.publishable? }
  end

  def build_pager
    elasticsearch = @article_params[:search].present?
    articles = Site::ArticleFinder.new(@article_params).find unless elasticsearch
    articles =  articles_from_elasticsearch if elasticsearch
    @pager = Pager.new(articles, current_page, POSTS_PER_PAGE, elasticsearch)
  end

  def transliterate(string)
    string.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
  end
end
