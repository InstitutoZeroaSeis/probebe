module MessageDeliveries
  class LessDeliveredCategoryFinder
    def initialize(deliveries_relation)
      @deliveries_relation = deliveries_relation
    end

    def find
      if deliveries.keys.first
        Category.find(deliveries.keys.first)
      else
        nil
      end
    end

    protected

    def deliveries
      @found_deliveries ||=
        @deliveries_relation.joins(message: [category: :parent_category])
        .group(Category.arel_table[:id])
        .order(Arel::Table.new(:parent_categories_categories)[:id].count)
        .count
    end
  end
end
