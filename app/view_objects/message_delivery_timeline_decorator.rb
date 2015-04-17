class MessageDeliveryTimelineDecorator < MessageDeliveries::MessageDelivery
  include Rails.application.routes.url_helpers

  def self.from_child(child)
    where(child: child).order_by_delivery_date.includes(:message => :messageable)
  end

  def self.default_period
    start_date = 1.month.ago.at_beginning_of_month.to_date if Date.today.day <= 17
    start_date = Date.today.at_beginning_of_month.to_date
    end_date = Date.today.to_date
    (start_date..end_date)
  end

  def self.month_period(date)
    (date.at_beginning_of_month.to_date..date.at_end_of_month.to_date)
  end

  def url
    if article.try :publishable
      posts_path(id: article.id)
    else
      '#'
    end
  end

end
