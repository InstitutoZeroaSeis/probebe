FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }

    trait :with_parent do
      association :parent_category, factory: :category
    end
  end
end
