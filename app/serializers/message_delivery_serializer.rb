class MessageDeliverySerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :text, :delivery_date, :url, :child_age_in_week_at_delivery, :article_category,
            :article_text, :article_title, :mon_is_pregnant, :category_id

  def text
    object.text
  end

  def url
    if object.article.try(:publishable?)
      article_url(object.article)
    end
  end

  def article_category
    object.message.category.name
  end

  def article_text
    if object.article.try(:publishable?)
      object.article.text
    end
  end

  def article_title
    if object.article.try(:publishable?)
      object.article.title
    end
  end

  def mon_is_pregnant
    object.mon_is_pregnat
  end

  def category_id
    object.message.category.id
  end
end
