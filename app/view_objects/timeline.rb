class Timeline
  def initialize(deliveries, deliveries_by_period, period)
    @deliveries = deliveries
    @period = period
    @deliveries_by_period = deliveries_by_period
  end

  def timeline_days
    ordered_days_till_now.map do |date|
      event = find_event_for_date date
      TimelineDay.new(date, event)
    end
  end

  def timeline_months
    delivered_months.map do |date|
      TimelineMonth.new(date)
    end
  end

  protected

  def delivered_months
    if @deliveries.any?
      (start_month_date..end_month_date).map{ |d| Date.new(d.year, d.month, 1) }.uniq.reverse
    else
      []
    end
  end

  def start_month_date
    @deliveries.last.delivery_date
  end

  def end_month_date
    @period.first.ago(1.month)
  end

  def find_event_for_date(date)
    ordered_deliveries_by_period.find {|delivery| delivery.delivery_date == date }
  end

  def ordered_deliveries_by_period
    if @deliveries_by_period.any?
      @deliveries_by_period.sort_by{|delivery| delivery.delivery_date}.reverse
    else
      []
    end
  end

  def ordered_days_till_now
    @period.to_a.reverse
  end

end
