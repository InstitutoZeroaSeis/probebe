module MessageDeliveries
  class LessDeliveredCategoryFinder
    def initialize(deliveries_relation, categories_relation = Category.default_scoped)
      @deliveries_relation = deliveries_relation
      @categories_relation = categories_relation
    end

    def find
      @categories_relation
        .select(Arel.star, count_subquery)
        .base_categories
        .joins(:categories)
        .order('categories_count asc')
        .first
    end

    protected

    def count_subquery
      count_sql = Message
        .joins(:message_deliveries)
        .merge(@deliveries_relation)
        .where('category_id = categories_categories.id')
        .select('count(*)')
        .to_sql
      "(#{count_sql}) as categories_count"
    end
  end
end
