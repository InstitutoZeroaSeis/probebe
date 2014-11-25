module Articles
  class JournalisticArticleUpdater

    def self.update_journalistic_from_authorial_article(authorial_article)
      atribbutes = [:baby_target_type, :category_id, :gender,
                    :minimum_valid_week, :maximum_valid_week,
                    :teenage_pregnancy]

      authorial_article.journalistic_articles.each do |journalistic|
        copy_attributes(authorial_article, journalistic, atribbutes)
      end
    end

    protected

    def self.copy_attributes(authorial_article, journalistic_article, atribbutes)
      atribbutes.each do |attribute|
        journalistic_article[attribute] = authorial_article[attribute]
      end
      journalistic_article.save!
    end

  end
end
