module MessageDeliveries
  class MessageDeliveryCreator
    attr_accessor :system_date

    def initialize(system_date, testing_mode: false)
      @system_date = system_date
      @testing_mode = testing_mode
    end

    def create_delivery_for(child)
      message = find_message_for_child(child)
      create_message_delivery(child, message)
    end

    def create_deliveries_for (child)
      message = find_message_for_child(child)
      create_retroactive_message_delivery(child, message)
    end

    protected

    def create_message_delivery(child, message)
      return unless message
      return if child.message_deliveries.created_today.size > 0
      MessageDelivery.create(
        message: message,
        child: child,
        message_for_test: @testing_mode,
        cell_phone_number: child.primary_cell_phone_number,
        device_registrations: child.device_registrations,
        sms_allowed: child.device_registrations.empty?,
        child_age_in_week_at_delivery: child.age_in_weeks,
        mon_is_pregnat: child.pregnancy?
      )
    end

    def create_retroactive_message_delivery(child, message)
      return unless message
      MessageDelivery.create(
        message: message,
        child: child,
        message_for_test: @testing_mode,
        cell_phone_number: child.primary_cell_phone_number,
        device_registrations: child.device_registrations,
        sms_allowed: child.device_registrations,
        child_age_in_week_at_delivery: child.age_in_weeks(@system_date),
        mon_is_pregnat: child.pregnancy?(@system_date),
        delivery_date: @system_date.date,
        status: :sent
      )
    end

    def create_donated_message(donor, message_delivery)
      return unless message_delivery
      DonatedMessage.create donor: donor, message_delivery: message_delivery
    end

    def find_message_for_child(child)
      message_matcher = MessageDeliveries::MessageMatcher.new(
        messages_to_send, child, @system_date
      )
      message_matcher.match_message_for_child
    end

    def messages_to_send
      Message.eager_load(:article, :category).
              where('articles.publishable = ?', true)
    end
  end
end
