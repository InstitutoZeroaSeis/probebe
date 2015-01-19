class Timeline
  def initialize(child)
    @child = child
    @deliveries = @child.message_deliveries.order_by_delivery_date.includes(:message)
    @last_date = @deliveries.last.delivery_date
  end

  def timeline_days
    ordered_days_till_now.map do |date|
      event = find_event_for_date date
      TimelineDay.new(date, event)
    end
  end

  protected

  def find_event_for_date(date)
    @deliveries.find {|d| d.delivery_date == date }
  end

  def ordered_days_till_now
    (@last_date..Date.today).to_a.reverse
  end
end
