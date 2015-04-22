module Blog
  class PostByCategoryFinder
    def initialize(category_name, relation)
      @category_name = category_name
      @relation = relation
    end

    def find
      if(@category_name)
        @relation.joins(:category).merge(Category.send(@category_name))
      else
        @relation
      end
    end
  end
end
