module Articles
  class ArticleFactory
    PROPERTIES = [
      :baby_target_type, :category_id, :gender,
      :minimum_valid_week, :maximum_valid_week,
      :tags, :teenage_pregnancy, :text, :title
    ]

    def build
      Articles::ArticleWithImageCover.new
    end

  end
end
