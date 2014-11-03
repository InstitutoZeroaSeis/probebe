FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@server.com"}
    password "12345678"

    trait :with_profile do
      profile
    end
  end
end
