module Articles
  class ArticleWithImageCover < Article
    validates :cover, presence: true

    def self.model_name
      Article.model_name
    end

    def self.sti_name
      Article.sti_name
    end
  end
end
