FactoryGirl.define do
  factory :category do
    sequence(:name) {|n| "#{n}category"}
  end

  trait :with_parent do
    association :parent_category, factory: :category
  end

  trait :with_parent_category_same_as_self do
    after(:build) do |category|
      category.parent_category = category
    end
  end

  trait :with_subcategories do
    sub_categories { create_list(:category, 2) }
  end
end
