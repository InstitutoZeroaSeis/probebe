class MessageDeliverySerializer < ActiveModel::Serializer
  attributes :id, :text, :delivery_date

  def text
    object.message.text
  end
end
