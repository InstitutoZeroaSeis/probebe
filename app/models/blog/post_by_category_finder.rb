module Blog
  class PostByCategoryFinder
    def initialize(category_id, relation)
      @category_id = category_id
      @relation = relation
    end

    def find
      return @relation unless @category_id
      category_ids = Category.where(parent_category_id: @category_id)
      @relation
        .joins(:category)
        .merge(Category.where(id: category_ids))
    end
  end
end
