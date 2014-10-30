FactoryGirl.define do
  factory :child do
    sequence(:name) {|n| "Child #{n}" }
    born true
    sequence(:birth_date) { 2.years.ago }
    gender 0

    trait :born do
      born true
    end

    trait :not_born do
      born false
    end

    trait :with_birth_date do
      birth_date { 2.years.ago }
    end

    trait :without_birth_date do
      birth_date nil
    end

    trait :with_pregnancy_start_date do
      pregnancy_start_date { 12.weeks.ago }
    end

    trait :without_pregnancy_start_date do
      pregnancy_start_date nil
    end
  end
end
