FactoryGirl.define do
  factory :phone do
    number "12345678"
    area_code "111"
    phone_type 0

    trait :smartphone do
      phone_type 0
    end

    trait :dumpphone do
      phone_type 1
    end

    trait :residential do
      phone_type 2
    end
  end
end