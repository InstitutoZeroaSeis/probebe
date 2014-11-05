FactoryGirl.define do
  factory :article, class: Articles::Article do
    sequence(:text) {|n| "Text#{n}"}
    sequence(:summary) {|n| "Summary#{n}"}
    type 'Articles::AuthorialArticle'
    user
    category
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

end