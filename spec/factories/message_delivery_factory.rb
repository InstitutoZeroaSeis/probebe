FactoryGirl.define do
  factory :message_delivery, class: "MessageDeliveries::MessageDelivery" do
    child
    message

    trait :sent do
      status 'sent'
    end

    trait :not_sent do
      status 'not_sent'
    end

    trait :with_device_registrations do
      device_registrations { create_list(:device_registration, 1) }
    end

  end
end
