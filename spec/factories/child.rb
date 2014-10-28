FactoryGirl.define do
  factory :child do
    sequence(:name) {|n| "Child #{n}" }
    sequence(:birth_date) { 2.years.ago }
    gender 0
  end
end
