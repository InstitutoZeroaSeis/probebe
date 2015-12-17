class MessageDeliverySerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :text, :delivery_date, :url, :child_age_in_week_at_delivery

  def text
    object.text
  end

  def url
    if object.article.try(:publishable?)
      article_url(object.article)
    end
  end
end
