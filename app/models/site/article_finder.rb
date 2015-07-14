module Site
  class ArticleFinder
    def initialize(options = {})
      @search = options[:search]
      @category_id = options[:category_id]
      @tag_name = options[:tag_name]
      @life_period = options[:life_period]
      @author_id = options[:author_id]
      @initial_relation = options[:initial_relation] || Site::Article.joins(:category).where('categories.blog_section = ?', false)
    end

    def find
      ordered_articles = Site::ArticleOrderByCreation.new(@initial_relation).sort
      articles_by_search_name = Site::ArticleSearchTermFinder.new(@search, ordered_articles).find
      articles_by_category = Site::ArticleByCategoryFinder.new(@category_id, articles_by_search_name).find
      articles_by_tag = Site::ArticleByTagFinder.new(@tag_name, articles_by_category).find
      articles_by_author = Site::ArticleByAuthorFinder.new(@author_id, articles_by_tag).find
      Site::ArticleByChildLifePeriodFinder.new(@life_period, articles_by_author).find
    end
  end
end
