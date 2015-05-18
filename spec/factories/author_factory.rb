FactoryGirl.define do
  factory :author, class: Authors::Author do
    sequence(:name) { |n| "Name #{n}" }
    sequence(:bio) { |n| "Bio #{n}" }
  end
end
