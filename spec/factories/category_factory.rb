FactoryGirl.define do
  factory :category do
    sequence(:name) {|n| "#{n}category"}
    parent_category 'health'
  end

end
