FactoryGirl.define do
  factory :user do
    sequence(:first_name) {|n| "First name #{n}"}
    sequence(:last_name) {|n| "Last name #{n}"}
    sequence(:email) {|n| "email#{n}@server.com"}
    password "12345678"
  end
end
