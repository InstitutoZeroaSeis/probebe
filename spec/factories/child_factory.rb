FactoryGirl.define do
  factory :child do
    sequence(:name) {|n| "Child #{n}" }
    sequence(:birth_date) { 2.years.ago }
    gender 'male'

    trait :with_birth_date do
      birth_date { 2.years.ago }
    end

    trait :without_birth_date do
      birth_date nil
    end

  end
end
