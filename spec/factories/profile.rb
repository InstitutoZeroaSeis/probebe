FactoryGirl.define do
  factory :profile do
    user

    trait :with_personal_profile do
      personal_profile
    end
  end
end
