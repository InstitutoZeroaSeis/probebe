module MessageDeliveries
  class CategoryMatcher
    MAXIMUMA_DELIVERED_MESSAGE_NUMBER_PER_MONTH = 20

    attr_reader :child

    def initialize(child)
      @child = child
    end

    def find_least_delivered_category
      minimum_sended = MAXIMUM_DELIVERED_MESSAGE_NUMBER_PER_MONTH
      least_category = nil
      categories_array = amount_of_parent_category
      categories_array.each do |key, value|
        if (value < minimum_sended)
            minimum_sended = value
            least_category = key
        end
      end
      least_category
    end

    protected

    def amount_of_parent_category
      parent_category_count = Hash.new
      Category.defined_enums['parent_category'].keys.each do |key|
        number = @child.message_deliveries.created_in_a_month.joins(:message).merge(Message.joins(:category).merge(Category.send(key))).count
        parent_category_count[key] = number
      end
    end

  end
end
