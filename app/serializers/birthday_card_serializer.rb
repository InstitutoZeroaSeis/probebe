class BirthdayCardSerializer < ActiveModel::Serializer
  attributes :age, :text, :url, :type

  def url
    object.avatar.url
  end

end
