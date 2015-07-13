module Site
  class ArticleByCategoryFinder
    def initialize(category_id, relation)
      @category_id = category_id
      @relation = relation
    end

    def find
      return @relation unless @category_id
      @relation.joins(:category).merge(
        Category.where(parent_category_id: @category_id)
      )
    end
  end
end
