FactoryGirl.define do
  factory :device_registration do
    platform 'Android'
    sequence(:platform_code) {|n| "Android_Device_#{n}"}
  end
end
