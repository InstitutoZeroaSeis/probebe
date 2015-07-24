module MessageDeliveries
  module DeviceRegistrations
    class DeviceRegistrationDestroyer

      def self.destroy(platform_code)
        registration = MessageDeliveries::DeviceRegistration.find_by(platform_code: platform_code)
        return if registration.nil?
        destroy_sns_endpoint(registration)
        registration.destroy
      end

      def self.destroy_sns_endpoint(registration)
        amazon_sns = MessageDeliveries::DeviceRegistrations::AmazonSns.new
        amazon_sns.delete_endpoint(registration.endpoint_arn)
      end

    end
  end
end
