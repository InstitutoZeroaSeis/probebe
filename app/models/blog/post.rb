class Blog::Post < Articles::JournalisticArticle
  default_scope -> { where(publishable: true) }

  def self.sti_name
    'Articles::JournalisticArticle'
  end
end
