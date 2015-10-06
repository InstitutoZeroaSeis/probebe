module MessageDeliveries
  module DeviceRegistrations
    class DeviceRegistrationCreator

      def self.create(params, profile)
        registration = MessageDeliveries::DeviceRegistration.new
        registration.assign_attributes params
        registration.profile = profile
        profile.possible_donor! if !profile.donor?
        profile.unauthorize_receive_sms!
        registration.save
        create_sns_endpoint(registration)
        registration
      end

      def self.create_sns_endpoint(registration)
        amazon_sns = MessageDeliveries::DeviceRegistrations::AmazonSns.new
        result = amazon_sns.create_endpoint(registration.platform_code, registration.profile_id)
        if result.present?
          registration.update_attributes(endpoint_arn: result[:endpoint_arn])
          enable_endpoint result[:endpoint_arn]
        end
      end

      def self.enable_endpoint endpoint_arn
        amazon_sns = MessageDeliveries::DeviceRegistrations::AmazonSns.new
        amazon_sns.enable_endpoint(endpoint_arn)
      end
    end
  end
end
