class MessageDeliveryTimelineDecorator < MessageDeliveries::MessageDelivery
  include Rails.application.routes.url_helpers

  def self.from_child(child)
    where(child: child).
    where.not(delivery_date: nil).
    order_by_delivery_date.includes(:message => :article)
  end

  def self.from_child_by_period(child, period)
    from_child(child).delivered_in_period(period)
  end

  def self.default_period
    start_date = 1.month.ago.at_beginning_of_month.to_date if Date.today.day <= 17
    start_date = Date.today.at_beginning_of_month.to_date
    end_date = Date.today.to_date
    (start_date..end_date)
  end

  def self.timeline(child, period)
    deliveries = from_child(child)
    deliveries_by_period = from_child_by_period(child, period)
    @timeline = Timeline.new deliveries, deliveries_by_period, period
  end

  def self.month_period(date)
    (date.at_beginning_of_month.to_date..date.at_end_of_month.to_date)
  end

  def url
    if article.try :publishable
      article_path(article)
    else
      '#'
    end
  end

end
