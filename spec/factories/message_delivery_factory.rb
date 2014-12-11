FactoryGirl.define do
  factory :message_delivery, class: "MessageDeliveries::MessageDelivery" do
    child
    message
  end
end
