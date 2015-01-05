FactoryGirl.define do
  factory :message_delivery, class: "MessageDeliveries::MessageDelivery" do
    child
    message

    trait :with_profile do
      transient do
        profile nil
      end

      after(:build) do |message_delivery, evaluator|
        message_delivery.child.profile = evaluator.profile ||
          create(:profile, :with_cell_phone)
      end
    end
  end
end
