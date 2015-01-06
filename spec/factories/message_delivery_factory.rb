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

    trait :with_profile do
      after(:build) do |obj|
        obj.child = create(:child, :with_profile)
      end
    end
  end
end
