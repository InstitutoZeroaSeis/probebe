class ChildSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :birth_date, :age_in_weeks, :pregnancy?
  has_many :message_deliveries, root: :messages, serializer: MessageDeliverySerializer


  def message_deliveries
    object.message_deliveries.order(delivery_date: :desc).limit(100)
  end
end
