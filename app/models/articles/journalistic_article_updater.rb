module Articles
  class JournalisticArticleUpdater
    PROPERTIES = [
      :baby_target_type, :category_id, :gender, :minimum_valid_week,
      :maximum_valid_week, :teenage_pregnancy
    ]

    def initialize(article)
      @article = article
    end

    def update_all!
      @article.journalistic_articles.each do |journalistic_article|
        copy_properties(journalistic_article)
        journalistic_article.save!
      end
    end

    protected

    def copy_properties(to)
      PROPERTIES.each do |prop|
        to.send("#{prop}=", @article.send(prop))
      end
    end
  end
end
