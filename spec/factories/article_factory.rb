FactoryGirl.define do
  factory :article, class: Articles::Article do
    sequence(:text) {|n| "Text#{n}"}
    sequence(:title) {|n| "Title#{n}"}
    sequence(:summary) {|n| "Summary#{n}"}
    type 'Articles::AuthorialArticle'
    user
    association :category, factory: [:category, :with_parent]
    tags { [FactoryGirl.create(:tag)] }

    factory :authorial_article, class: Articles::AuthorialArticle do
      type 'Articles::AuthorialArticle'
    end

    factory :journalistic_article, class: Articles::JournalisticArticle do
      type 'Articles::JournalisticArticle'
      association :original_author, factory: :user
      with_parent_authorial_article

      trait :with_parent_authorial_article do
        association :parent_article, factory: :authorial_article
      end

      trait :with_parent_journalistic_article do
        association :parent_article, factory: :journalistic_article
      end

      trait :without_parent_article do
        parent_article nil
      end

      trait :without_original_author do
        original_author nil
      end

    end
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
