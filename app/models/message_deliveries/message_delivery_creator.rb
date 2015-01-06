module MessageDeliveries
  class MessageDeliveryCreator

    def initialize(system_date, testing_mode: false)
      @system_date = system_date
      @testing_mode = testing_mode
    end

    def create_deliveries_for_all_children
      Child.all.map do |child|
        message = find_message_for_child(child)
        create_message_delivery(child, message)
      end.select do |item|
        item.present?
      end
    end

    protected

    def create_message_delivery(child, message)
      if message
        MessageDelivery.create(
          message: message,
          child: child,
          message_for_test: @testing_mode,
          cell_phone_number: child.primary_cell_phone_number
        )
      end
    end

    def find_message_for_child(child)
      message_matcher = MessageDeliveries::MessageMatcher.new(messages_to_send, child, @system_date )
      messages = message_matcher.find_messages_for_child
      messages.first
    end

    def messages_to_send
      Message.journalistic
    end

  end
end
