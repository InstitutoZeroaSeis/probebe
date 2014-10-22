FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@server.com"}
    password "12345678"
  end
end
