FactoryGirl.define do
  factory :device_registration_hash, class: Hash do
    platform "android"
    sequence(:platform_code) {|n| "Platform Code #{n}"}

    initialize_with { attributes }
  end
end
