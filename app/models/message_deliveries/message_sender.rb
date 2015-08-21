module MessageDeliveries
  class MessageSender
    def initialize(message_delivery)
      @message_delivery = message_delivery
    end

    def send_to_device
      if @message_delivery.device_registrations.empty?
        deliver_through_sms
      else
        deliver_through_app
      end
    end

    protected

    def deliver_through_sms
      return false if sms_should_not_be_sent? ||
        @message_delivery.cell_phone_number.nil?

      MessageDeliveries::ZenviaSmsSender.send(
        number_for_delivery,
        @message_delivery.text
      )
    end

    def number_for_delivery
      @message_delivery.cell_phone_number.gsub(/([^\d])+/, '')
    end

    def sms_should_not_be_sent?
      !ProBebeConfig.deliver_sms? || !@message_delivery.sms_allowed
    end

    def deliver_through_app
      amazon_sns = MessageDeliveries::DeviceRegistrations::AmazonSns.new
      @message_delivery.device_registrations.each do |device_registration|
        amazon_sns.send_message device_registration.endpoint_arn, @message_delivery.text
      end
      true
    end
  end
end
