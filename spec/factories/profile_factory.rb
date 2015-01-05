FactoryGirl.define do
  factory :profile do
    sequence(:first_name) {|n| "Name#{n}"}
    sequence(:last_name) {|n| "Surname#{n}"}
    gender 'male'
    birth_date {20.years.ago}
    cell_phones { create_list :cell_phone, 2 }
    user
    children { create_list :child, 2 }

    trait :with_cell_phone do
      cell_phones { create_list :cell_phone, 2 }
    end

    trait :without_cell_phone do
      cell_phones []
    end

    trait :with_children do
      children { create_list :child, 2 }
    end

    trait :without_children do
      children []
    end

    trait :with_birth_date do
      birth_date {20.years.ago}
    end

    trait :without_birth_date do
      birth_date nil
    end

    trait :with_device_registration do
      device_registrations { create_list :device_registration, 1 }
    end

  end
end
