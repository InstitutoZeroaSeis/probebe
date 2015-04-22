class CategorySampleArticlesDecorator < Category

  def self.group_by_parent_category
    Category::PARENT_CATEGORY_ENUM.map{ |category| {category: category, articles: two_ordered_articles_from_category(category) } }
  end

  def self.two_ordered_articles_from_category parent_category
    categories = from_parent_category(parent_category)
    Articles::Article.journalistic.where(category: categories).sample(2)
  end

  def self.from_parent_category parent_category
    where(parent_category: parent_category)
  end

end
