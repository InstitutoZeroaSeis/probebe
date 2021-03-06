module MessageDeliveries
  module DeviceRegistrations
    class AmazonSns
      def initialize
        @sns = Aws::SNS::Client.new
      end

      def create_endpoint(platform, platform_code, profile_id)
        if platform.downcase == 'ios'
          @arn = ENV['AWS_SNS_IOS_ARN']
        else
          @arn = ENV['AWS_SNS_GCM_ARN']
        end

        begin
          Rails.logger.debug "[AmazonSNS] - create_endpoint, platform_code: #{platform_code},
                                            profile_id: #{profile_id}"
          return @sns.create_platform_endpoint(
            platform_application_arn: @arn,
            token: platform_code,
            custom_user_data:  {profile_id: profile_id}.to_json
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

      def send_message(platform, target_arn, message, image_url)
        begin
          Rails.logger.debug "[AmazonSNS] - send_message, target_arn: #{target_arn}, message: #{message}"
          return if message.blank?
          title = 'ProBebe'

          if platform.downcase == 'ios'
            sns_message = '{"APNS": "{\"aps\":{\"alert\": \"' + message + '\", \"badge\": 1,\"sound\": \"default\"} }"}'
          else
            sns_message = '{"GCM": "{ \"data\": { \"title\": \"' + title + '\", \"message\": \"' + message + '\", \"style\": \"picture\", \"picture\": \"' + image_url + '\", \"summaryText\": \"' + message + '\", \"soundname\": \"baby_laughing_01\" } }"}'
          end

          return @sns.publish({
            target_arn: target_arn,
            message: sns_message,
            message_structure: 'json',
            subject: "subject"
          })
        rescue => e
          Rails.logger.error "[AmazonSNS] - A error occurs on send_message: #{e}"
          return nil
        end
      end

      def get_endpoint(target_arn)
        return @sns.get_endpoint_attributes({endpoint_arn: target_arn})
      end

      def enable_endpoint(endpoint_arn)
        return @sns.set_endpoint_attributes({
          endpoint_arn: endpoint_arn,
          attributes: {
            "Enabled" => "true"
          }
        })
      end
    end
  end
end
