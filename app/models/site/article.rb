class Site::Article < Articles::Article
  default_scope -> { where(publishable: true) }

    def self.model_name
      Articles::Article.model_name
    end

    def self.sti_name
      Articles::Article.sti_name
    end

    def category_color
      return self.category.parent_category.color if self.category.parent_category.present?
      ''
    end
end
