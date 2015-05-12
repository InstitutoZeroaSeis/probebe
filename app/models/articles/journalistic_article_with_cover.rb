class Articles::JournalisticArticleWithCover < Articles::JournalisticArticle
  has_attached_file :data, styles: { content: '1920>', thumb: '118x100#' }

  validates :image_cover, presence: true

  def self.model_name
    Articles::JournalisticArticle.model_name
  end

  def self.sti_name
    Articles::JournalisticArticle.sti_name
  end
end
