module MessageDeliveries
  class CategoryMatcher
    attr_reader :child

    def initialize(child)
      @child = child
    end

    def find_least_delivered_category
      category = amount_of_parent_category.min do |category_a, category_b|
        category_a[:count] <=> category_b[:count]
      end
      category[:name]
    end

    protected

    def amount_of_parent_category
      Category.defined_enums['parent_category'].keys.map do |category_name|
        messages_in_category_count = @child.message_deliveries.created_in_a_month.joins(:message).merge(Message.joins(:category).merge(Category.send(category_name))).count
        { name: category_name, count: messages_in_category_count }
      end
    end

  end
end
