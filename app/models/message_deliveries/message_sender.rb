module MessageDeliveries
  class MessageSender
    def initialize(message_delivery)
      @message_delivery = message_delivery
    end

    def send_to_device
      if @message_delivery.sms_allowed? and @message_delivery.child.device_registrations.empty?
        # deliver_through_sms
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
        text_by_gender
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
        amazon_sns.send_message device_registration.platform, device_registration.endpoint_arn, text_by_gender, @message_delivery.message.article.thumb_image_cover.url(:content)
      end
      true
    end

    def text_by_gender
      gender = @message_delivery.child.profile.gender
      if gender.present?
        gender == 'male' ? @message_delivery.father_text : @message_delivery.text
      else
        @message_delivery.text
      end
    end
  end
end
