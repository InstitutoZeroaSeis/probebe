class Blog::Post < Articles::Article
  default_scope -> { where(publishable: true) }

    def self.model_name
      Articles::Article.model_name
    end

    def self.sti_name
      Articles::Article.sti_name
    end
end
