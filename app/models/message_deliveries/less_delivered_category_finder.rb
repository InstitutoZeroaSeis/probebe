module MessageDeliveries
  class LessDeliveredCategoryFinder
    def initialize(deliveries_relation)
      @deliveries_relation = deliveries_relation
    end

    def find
      Category
        .select(Arel.star, count_subquery)
        .base_categories
        .joins(:categories)
        .order('categories_count asc')
        .first
    end

    protected

    def count_subquery
      %(
        (
          SELECT COUNT(*) FROM messages
          INNER JOIN message_deliveries
          ON messages.id = message_deliveries.message_id
          WHERE messages.category_id = categories_categories.id
        )
        AS categories_count
      )
    end
  end
end
