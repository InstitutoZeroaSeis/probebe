module Articles
  class JournalisticArticleWithImageCover < JournalisticArticle
    validates :cover, presence: true

    def self.model_name
      JournalisticArticle.model_name
    end

    def self.sti_name
      JournalisticArticle.sti_name
    end
  end
end
