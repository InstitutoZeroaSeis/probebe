FactoryGirl.define do
  factory :device_registration, class: "MessageDeliveries::DeviceRegistration" do
    platform 'Android'
    sequence(:platform_code) {|n| "Android_Device_#{n}"}

    trait :with_profile do
      profile
    end
  end
end
