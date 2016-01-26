module MessageDeliveries
  class MessageDeliveryCreator
    def initialize(system_date, testing_mode: false)
      @system_date = system_date
      @testing_mode = testing_mode
    end

    def create_deliveries_for_all_children
      Child.all.map do |child|
        message = find_message_for_child(child)
        message_delivery = create_message_delivery(child, message)
        create_donated_message(child.donor, message_delivery) if child.donor.present?
        message_delivery
      end.select(&:present?)
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
        sms_allowed: child.authorized_receive_sms,
        child_age_in_week_at_delivery: child.age_in_weeks,
        mon_is_pregnat: child.pregnancy?
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
      Message.joins(:article).
              where('articles.publishable = ?', true)
    end
  end
end
