class DonatedMessageSerializer < ActiveModel::Serializer
  attributes :id, :message, :phone_number

  def message
    object.message_delivery.message.text
  end

  def phone_number
    number = object.message_delivery.cell_phone_number.gsub(/([^\d])+/, '')
    "55#{number}"
  end
end
