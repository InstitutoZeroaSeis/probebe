module MessageDeliveries
  class CategoryMatcher
    def initialize(child)
      @child = child
    end

    def find_least_delivered_category
      category = categories_and_count.min do |category_a, category_b|
        category_a[:count] <=> category_b[:count]
      end
      category[:name]
    end

    protected

    def categories_and_count
      Category.where(id: @child.category_ids).map do |category|
        sent_messages_count = find_messages_for_category(category).count
        { name: category.name, count: sent_messages_count }
      end
    end

    def find_messages_for_category(category)
      @child
        .message_deliveries
        .joins(message: :category)
        .merge(Category.where(id: category.id))
    end
  end
end
