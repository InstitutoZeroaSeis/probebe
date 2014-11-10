FactoryGirl.define do
  factory :authorial_article, class: Articles::AuthorialArticle do
    sequence(:text) {|n| "Text#{n}"}
    sequence(:summary) {|n| "Summary#{n}"}
    user
    association :category, factory: [:category, :with_parent]
  end
end
