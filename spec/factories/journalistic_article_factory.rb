FactoryGirl.define do
  factory :journalistic_article, class: Articles::JournalisticArticle do
    sequence(:text) {|n| "Text#{n}"}
    sequence(:summary) {|n| "Summary#{n}"}
    user
    category
    tags { [FactoryGirl.create(:tag)] }
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