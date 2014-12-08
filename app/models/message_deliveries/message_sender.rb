module MessageDeliveries
  class MessageSender
    attr_reader :child

    def initialize(child, system_date)
      @child = child
      @system_date = system_date
    end

    def send_message(testing_mode = false)
      messages = get_messages

      if messages.count > 0
        MessageDelivery.create!(
          message: messages.first,
          profile: @child.profile,
          delivery_date: @system_date.date,
          message_for_test: testing_mode
        )
      end
    end

    protected

    def get_messages
      articles_matcher = MessageDeliveries::ArticlesMatcher.new(articles, @child, @system_date)
      message_matcher = MessageDeliveries::MessageMatcher.new(articles_matcher)
      message_matcher.find_message_for_child
    end

    def articles
      Articles::JournalisticArticle.all
    end

  end
end
