FactoryGirl.define do
  factory :personal_profile do
    sequence(:first_name) {|n| "Name#{n}"}
    sequence(:last_name) {|n| "Surname#{n}"}
    gender 0
    profile
  end
end
