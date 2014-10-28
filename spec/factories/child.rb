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

    trait :with_expected_birth_date do
      expected_birth_week { 6.months.from_now.to_date.cweek }
      expected_birth_year { 6.months.from_now.year }
    end

    trait :without_expected_birth_date do
      expected_birth_week nil
      expected_birth_year nil
    end
  end
end
