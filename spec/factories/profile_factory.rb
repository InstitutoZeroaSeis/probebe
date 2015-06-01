FactoryGirl.define do
  factory :profile do
    sequence(:name) { |n| "Name #{n}" }
    gender 'male'
    birth_date { 20.years.ago }
    children { create_list :child, 2 }

    trait :with_cell_phone do
      cell_phone '1112345678'
    end

    trait :without_cell_phone do
      cell_phone nil
    end

    trait :with_children do
      children { create_list :child, 2 }
    end

    trait :without_children do
      children []
    end

    trait :with_birth_date do
      birth_date { 20.years.ago }
    end

    trait :without_birth_date do
      birth_date nil
    end

    trait :with_device_registration do
      device_registrations { create_list :device_registration, 1 }
    end
  end
end
