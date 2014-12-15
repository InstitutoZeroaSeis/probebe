class ChildSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :birth_date
  has_many :message_deliveries, root: :messages, serializer: MessageDeliverySerializer
end
