class Timeline
  def initialize(deliveries)
    @deliveries = deliveries.sort_by{|delivery| delivery.delivery_date}.reverse
  end

  def timeline_days
    ordered_days_till_now.map do |date|
      event = find_event_for_date date
      TimelineDay.new(date, event)
    end
  end

  protected

  def start_date
    @deliveries.last.delivery_date
  end

  def find_event_for_date(date)
    @deliveries.find {|delivery| delivery.delivery_date == date }
  end

  def ordered_days_till_now
    if @deliveries.any?
      (start_date..Date.today).to_a.reverse
    else
      []
    end
  end
end
