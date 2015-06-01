module Blog
  class CategoryGroupedPostsFinder
    ARTICLES_PER_CATEGORY = 2

    def find
      categories = Category.original_categories
      sort_by_home_order(categories).map do |category|
        [category, articles_from_category(category)]
      end.to_h
    end

    protected

    def articles_from_category(parent_category)
      categories = Category.where(parent_category_id: parent_category.id)
      Blog::Post
        .where(category_id: categories)
        .sample(ARTICLES_PER_CATEGORY)
    end

    def sort_by_home_order(categories)
      categories.sort_by do |category|
        case category.original_category_type
        when 'health' then 0
        when 'education' then 1
        when 'behavior' then 2
        when 'security' then 3
        when 'finance' then 4
        else 5
        end
      end
    end
  end
end
