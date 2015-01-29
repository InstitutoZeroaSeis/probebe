FactoryGirl.define do
  factory :category do
    sequence(:name) {|n| "#{n}category"}
    parent_category 'health'
  end

  trait :with_health_parent do
    parent_category 'health'
  end

  trait :with_education_parent do
    parent_category 'education'
  end

  trait :with_security_parent do
    parent_category 'security'
  end

  trait :with_finance_parent do
    parent_category 'finance'
  end

  trait :with_socio_emotional_parent do
    parent_category 'socio_emotional'
  end
end
