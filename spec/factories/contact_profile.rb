FactoryGirl.define do
  factory :contact_profile do
    profile

    trait :with_smartphone do
      phones { create_list :phone, 2, :smartphone }
    end

    trait :with_dumpphone do
      phones { create_list :phone, 2, :dumpphone }
    end
    trait :with_residential_phone do
      phones { create_list :phone, 2, :residential}
    end
  end
end
