FactoryGirl.define do
  factory :message do
    text "Test"

    trait :with_journalistic_article do
      association :messageable, factory: :journalistic_article
    end
  end
end
