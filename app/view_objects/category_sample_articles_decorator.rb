class CategorySampleArticlesDecorator
  COUNT_OF_ARTICLES_TO_FIND = 2

  def self.group_by_parent_category
    Category.original_categories.map do |category|
      [category, articles_from_category(category)]
    end.to_h
  end

  def self.articles_from_category(parent_category)
    categories = Category.where(parent_category_id: parent_category.id)
    Blog::Post
      .where(category_id: categories)
      .sample(COUNT_OF_ARTICLES_TO_FIND)
  end
end
