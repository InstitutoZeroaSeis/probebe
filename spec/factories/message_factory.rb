FactoryGirl.define do
  factory :message do
    text "Test"
    gender 'both'
    baby_target_type 'pregnancy'
    category
  end

  trait :without_minimum_valid_week do
    minimum_valid_week nil
  end

  trait :without_maximum_valid_week do
    maximum_valid_week nil
  end

  trait :male do
    gender 'male'
  end

  trait :female do
    gender 'female'
  end
end
