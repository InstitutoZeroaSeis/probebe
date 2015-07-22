module MessageDeliveries
  module DeviceRegistrations
    class AmazonSns
      def initialize
        @sns = Aws::SNS::Client.new
        @arn = ENV['AWS_SNS_APP_ARN']
      end

      def create_endpoint(platform_code, device_registration_id)
        @sns.create_platform_endpoint(
          platform_application_arn: @arn,
          token: platform_code,
          custom_user_data:  "device_registration_id: #{device_registration_id}"
        )
      end

      def delete_endpoint(endpoint_arn)
        @sns.delete_endpoint(
          endpoint_arn: endpoint_arn,
        )
      end

      def send_message(target_arn, message)
        return if message.blank?
        @sns.publish({
          target_arn: target_arn,
          message: message
        })
      end
    end
  end
end
