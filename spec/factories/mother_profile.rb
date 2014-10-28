FactoryGirl.define do
  factory :mother_profile do
    is_mother false
    is_pregnant true
    profile
    children { create_list :child, 2 }
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

  trait :with_children do
    children { create_list :child, 2 }
  end

  trait :without_children do
    children []
  end
end
