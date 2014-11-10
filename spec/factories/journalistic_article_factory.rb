FactoryGirl.define do
  factory :journalistic_article, class: Articles::JournalisticArticle do
    sequence(:text) {|n| "Text#{n}"}
    sequence(:title) {|n| "Title#{n}"}
    sequence(:summary) {|n| "Summary#{n}"}
    user
    association :category, factory: [:category, :with_parent]
    tags { [FactoryGirl.create(:tag)] }
    association :parent_article, factory: :authorial_article
  end

  trait :with_parent_authorial_article do
    association :parent_article, factory: :authorial_article
  end

  trait :with_parent_journalistic_article do
    association :parent_article, factory: :journalistic_article
  end

  trait :without_parent_article do
     parent_article nil
  end

end
