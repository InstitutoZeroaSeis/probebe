FactoryGirl.define do
  factory :child do
    sequence(:name) {|n| "Child #{n}" }
    sequence(:birth_date) { 1.year.ago }
    gender 'male'

    trait :with_birth_date do
      birth_date { 2.years.ago }
    end

    trait :without_birth_date do
      birth_date nil
    end

    trait :with_profile do
      profile
    end

  end
end
