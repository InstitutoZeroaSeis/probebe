module Site
  class RelatedArticleFinder
    NUMBER_NECESSARY_OF_RELATED_POST = 3

    def initialize(article_id)
      @article_id = article_id
    end

    def find_related
      article = Site::Article.find(@article_id)
      ids = find_related_article_ids(article)
      Site::Article.where(id: ids)
    end

    protected

    def find_related_article_ids(article)
      tag_ids = article.tags.map(&:id)
      select_randomly(articles_by_tags(tag_ids).pluck(:id))
    end

    def select_randomly(article_ids)
      article_ids.reject do |id|
        id == @article_id
      end.sample(NUMBER_NECESSARY_OF_RELATED_POST)
    end

    def articles_by_tags(tags_name)
      Site::ArticleByTagFinder.new(tags_name, Site::Article).find
    end
  end
end
