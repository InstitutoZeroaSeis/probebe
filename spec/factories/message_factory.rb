FactoryGirl.define do
  factory :message do
    text "Test"
    category

    trait :with_journalistic_article do
      association :messageable, factory: :journalistic_article
    end

    trait :with_health_category do
      association :category, factory: [:category, :with_health_parent]
    end

    trait :with_security_category do
      association :category, factory: [:category, :with_security_parent]
    end

    trait :with_education_category do
      association :category, factory: [:category, :with_education_parent]
    end

    trait :with_finance_category do
      association :category, factory: [:category, :with_finance_parent]
    end

    trait :with_socio_emotional_category do
      association :category, factory: [:category, :with_socio_emotional_parent]
    end
  end
end
