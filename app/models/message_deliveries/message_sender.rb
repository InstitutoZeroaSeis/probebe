module MessageDeliveries
  class MessageSender
    attr_reader :child

    def initialize(messages_finder)
      @child = messages_finder.child
      @messages_finder = messages_finder
    end

    def send_messages(date = nil, message_for_test)
      delivery_date = date || Date.today
      message = get_first_message
      MessageDelivery.create!(message: message, profile: @child.profile,
                              delivery_date: delivery_date,
                              message_for_test: message_for_test) if message.present?
    end

    protected

    def get_messages
      @messages_finder.find_message_for_child
    end

    def get_first_message
      get_messages.first
    end
  end
end
