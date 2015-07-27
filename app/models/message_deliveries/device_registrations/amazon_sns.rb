module MessageDeliveries
  module DeviceRegistrations
    class AmazonSns
      def initialize
        @sns = Aws::SNS::Client.new
        @arn = ENV['AWS_SNS_APP_ARN']
      end

      def create_endpoint(platform_code, profile_id)
        begin
          Rails.logger.debug "[AmazonSNS] - create_endpoint, platform_code: #{platform_code},
                                            profile_id: #{profile_id}"
          return @sns.create_platform_endpoint(
            platform_application_arn: @arn,
            token: platform_code,
            custom_user_data:  "{profile_id: #{profile_id}}"
          )
        rescue => e
          Rails.logger.error "[AmazonSNS] - A error occurs on create_endpoint: #{e}"
          return nil
        end
      end

      def delete_endpoint(endpoint_arn)
        begin
          Rails.logger.debug "[AmazonSNS] - delete_endpoint, endpoint_arn: #{endpoint_arn}"
          return @sns.delete_endpoint(
            endpoint_arn: endpoint_arn,
          )
        rescue => e
          Rails.logger.error "[AmazonSNS] - A error occurs on delete_endpoint: #{e}"
          return nil
        end
      end

      def send_message(target_arn, message)
        begin
          Rails.logger.debug "[AmazonSNS] - send_message, target_arn: #{target_arn}, message: #{message}"
          return if message.blank?
          return @sns.publish({
            target_arn: target_arn,
            message: message
          })
        rescue => e
          Rails.logger.error "[AmazonSNS] - A error occurs on send_message: #{e}"
          return nil
        end
      end
    end
  end
end
