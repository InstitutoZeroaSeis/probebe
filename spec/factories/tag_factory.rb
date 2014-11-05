FactoryGirl.define do
  factory :tag do
    sequence(:name) {|n|"name#{n}"}
  end

  trait :without_name do 
    name nil
  end

end