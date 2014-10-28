FactoryGirl.define do
  factory :mother_profile do
    is_mother true
    is_pregnant false
    profile
  end

  trait :mother do
    is_mother true
  end

  trait :pregnant do
    is_pregnant true
  end

  trait :no_mother do
    is_mother false
  end

  trait :no_pregnant do
    is_pregnant false
  end

  trait :without_profile do
    profile nil
  end
end
