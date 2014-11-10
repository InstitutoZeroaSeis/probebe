FactoryGirl.define do
  factory :article, class: Articles::Article do
    sequence(:text) {|n| "Text#{n}"}
    sequence(:title) {|n| "Title#{n}"}
    sequence(:summary) {|n| "Summary#{n}"}
    type 'Articles::AuthorialArticle'
    user
    association :category, factory: [:category, :with_parent]
    tags { [FactoryGirl.create(:tag)] }
  end

  trait :without_user do
    user nil
  end

  trait :without_category do
    category nil
  end

  trait :without_text do
    text nil
  end

  trait :without_type do
    type nil
  end

  trait :without_title do
    title nil
  end
end
