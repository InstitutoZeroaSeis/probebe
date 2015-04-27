FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@server.com"}
    role 'site_user'
    password "12345678"
    profile

    trait :with_profile do
      profile
    end

    trait :site_user do
      role 'site_user'
    end

    trait :admin do
      role 'admin'
    end

    trait :author do
      role 'author'
    end

    trait :journalist do
      role 'journalist'
    end
  end
end
