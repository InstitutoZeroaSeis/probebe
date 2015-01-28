module MessageDeliveries
  class MessageMatcher
    attr_reader :messages
    attr_reader :child
    attr_reader :system_date

    def initialize(messages, child, system_date)
      @messages = messages
      @child = child
      @system_date = system_date
    end

    def find_messages_for_child
      message_filter = MessageDeliveries::MessageFilter.new(@messages, @child, @system_date)
      messages = message_filter.filter_message_for_child
    end

    protected

    def category_for_child
      category_matcher = MessageDeliveries::CategoryMatcher.new(@child)
      category = category_matcher.find_least_delivered_category
    end
  end
end
