FactoryGirl.define do
  factory :article, class: Articles::Article do
    sequence(:text) {|n| "Text#{n}"}
    sequence(:title) {|n| "Title#{n}"}
    sequence(:summary) {|n| "Summary#{n}"}
    gender 'both'
    baby_target_type 'pregnancy'
    minimum_valid_week 8
    type 'Articles::AuthorialArticle'
    user
    association :category, factory: [:category, :with_parent]
    tags { [FactoryGirl.create(:tag)] }

    factory :authorial_article, class: Articles::AuthorialArticle

    factory :journalistic_article, class: Articles::JournalisticArticle do
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

    end
  end

  trait :without_minimum_valid_week do
    minimum_valid_week nil
  end

  trait :without_maximum_valid_week do
    maximum_valid_week nil
  end

  trait :male do
    gender 'male'
  end

  trait :female do
    gender 'female'
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
