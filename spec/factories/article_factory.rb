FactoryGirl.define do
  factory :article, class: Articles::Article do
    sequence(:text) { |n| "Text#{n}" }
    sequence(:title) { |n| "Title#{n}" }
    sequence(:summary) { |n| "Summary#{n}" }
    gender 'both'
    baby_target_type 'pregnancy'
    minimum_valid_week 8
    user
    category { create(:category, :with_parent) }
    tags { [FactoryGirl.create(:tag)] }
    original_author { create(:author) }
    publishable true
    cover_picture { FactoryGirl.create(:ckeditor_asset) }
    thumb_picture { FactoryGirl.create(:ckeditor_asset) }

    factory :post, class: Site::Article do
      category { create(:category, :with_parent) }
    end

    trait :without_original_author do
      original_author nil
    end

    trait :random_created_at do
      created_at { rand(1..365).days.ago }
    end

    trait :published do
      publishable true
    end

    trait :unpublished do
      publishable false
    end

  end

  trait :without_minimum_valid_week do
    minimum_valid_week nil
  end

  trait :without_maximum_valid_week do
    maximum_valid_week nil
  end

  trait :both do
    gender 'both'
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

  trait :with_messages do
    messages { create_list :message, 2 }
  end
end
