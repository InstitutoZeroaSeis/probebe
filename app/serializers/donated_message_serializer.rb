class DonatedMessageSerializer < ActiveModel::Serializer
  attributes :id, :message

  def message
    object.message_delivery.message.text
  end
end
