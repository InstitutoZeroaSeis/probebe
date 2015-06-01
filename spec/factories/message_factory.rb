FactoryGirl.define do
  factory :message do
    text "Test"
    category

    factory :message_for_delivery do
      with_journalistic_article
    end

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

    trait :with_behavior_category do
      association :category, factory: [:category, :with_behavior_parent]
    end
  end
end
