FactoryGirl.define do
  factory :profile_creator_data, class: OmniAuth::AuthHash do
    sequence(:first_name) {|n| "First name #{n}"}
    sequence(:last_name) {|n| "Last name #{n}"}
    user
  end
end
