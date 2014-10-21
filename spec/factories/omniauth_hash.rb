FactoryGirl.define do
  factory :omniauth_hash, class: OmniAuth::AuthHash do
    sequence(:first_name) {|n| "First name #{n}"}
    sequence(:last_name) {|n| "Last name #{n}"}
    sequence(:email) {|n| "email#{n}@server.com"}
  end
end
