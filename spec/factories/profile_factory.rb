FactoryGirl.define do
  factory :profile do
    sequence(:name) { |n| "Name #{n}" }
    gender 'male'
    birth_date { 20.years.ago }
    cell_phone '11 88798-7654'
    children { create_list :child, 2 }

    trait :with_cell_phone do
      cell_phone '11 88798-7654'
    end

    trait :without_cell_phone do
      cell_phone nil
    end

    trait :with_children do
      children { create_list :child, 2 }
    end

    trait :with_site_user do
      user { create(:user, :site_user) }
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
