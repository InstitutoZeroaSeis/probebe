FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@server.com"}
    password "12345678"

    trait :with_profile do
      profile
    end

    trait :confirmed do
      before(:create) do |user|
        user.confirm!
      end
    end
  end
end
