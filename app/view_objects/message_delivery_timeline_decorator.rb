class MessageDeliveryTimelineDecorator < MessageDeliveries::MessageDelivery
  include Rails.application.routes.url_helpers

  def self.from_child(child)
    where(child: child).order_by_delivery_date.includes(:message => :messageable)
  end

  def url
    if article.try :publishable
      posts_path(id: article.id)
    else
      '#'
    end
  end

end
