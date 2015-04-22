class Articles::JournalisticArticleWithCover < Articles::JournalisticArticle
  validates :image_cover, presence: true

  def self.model_name
    Articles::JournalisticArticle.model_name
  end

  def self.sti_name
    Articles::JournalisticArticle.sti_name
  end
end
