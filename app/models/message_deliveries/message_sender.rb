module MessageDeliveries
  class MessageSender
    attr_reader :child

    def initialize(system_date)
      @system_date = system_date
    end

    def send_messages(testing_mode = false)
      Child.all.map do |child|
        messages = get_messages(child)

        if messages.count > 0
          MessageDelivery.create!(
            message: messages.first,
            profile: child.profile,
            delivery_date: @system_date.date,
            message_for_test: testing_mode
          )
        end
      end
        .delete_if(&:nil?)
    end

    protected

    def get_messages(child)
      message_matcher = MessageDeliveries::MessageMatcher.new(messages_to_send, child, @system_date )
      message_matcher.find_messages_for_child
    end

    def messages_to_send
      Message.journalistic
    end

  end
end
