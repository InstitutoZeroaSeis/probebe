FactoryGirl.define do
  factory :profile do
    sequence(:first_name) {|n| "Name#{n}"}
    sequence(:last_name) {|n| "Surname#{n}"}
    gender 'male'
    is_pregnant true
    is_mother false
    birth_date {20.years.ago}
    pregnancy_start_date { 3.months.ago }
    phones { create_list :phone, 2, :smartphone }
    user

    trait :with_smartphone do
      phones { create_list :phone, 2, :smartphone }
    end

    trait :with_dumbphone do
      phones { create_list :phone, 2, :dumbphone }
    end

    trait :with_residential_phone do
      phones { create_list :phone, 2, :residential}
    end

    trait :mother do
      is_mother true
      with_children
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

  end
end
