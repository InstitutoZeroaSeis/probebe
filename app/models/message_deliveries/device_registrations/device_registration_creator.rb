module MessageDeliveries
  module DeviceRegistrations
    class DeviceRegistrationCreator

      def self.create(params, profile)
        registration = MessageDeliveries::DeviceRegistration.new
        registration.assign_attributes params
        registration.profile = profile
        registration.save
        create_sns_endpoint(registration)
        registration
      end

      def self.create_sns_endpoint(registration)
        amazon_sns = MessageDeliveries::DeviceRegistrations::AmazonSns.new
        result = amazon_sns.create_endpoint(registration.platform_code, registration.id)
        registration.update_attributes(endpoint_arn: result[:endpoint_arn]) if result.present?
      end

    end
  end
end
