FactoryGirl.define do
  factory :message_delivery, class: 'MessageDeliveries::MessageDelivery' do
    child
    message
    cell_phone_number '123123123'
    sms_allowed true

    transient do
      category nil
    end

    after(:build, :stub) do |delivery, evaluator|
      next unless evaluator.category
      delivery.message = create(:message, :with_article, category: evaluator.category)
    end

    trait :sent do
      status 'sent'
    end

    trait :not_sent do
      status 'not_sent'
    end

    trait :with_device_registrations do
      device_registrations { create_list(:device_registration, 1, profile: create(:profile)) }
    end

  end
end
