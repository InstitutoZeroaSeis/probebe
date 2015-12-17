class ChildSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :birth_date, :age_in_weeks, :pregnancy?
  has_many :message_deliveries, root: :messages, serializer: MessageDeliverySerializer

end
