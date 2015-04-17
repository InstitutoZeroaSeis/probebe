class Timeline
  def initialize(deliveries, period)
    @all_deliveries = deliveries
    @period = period
    @deliveries = ordered_deliveries_by_period
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
    if @all_deliveries.any?
      (start_month_date..end_month_date).map{ |d| Date.new(d.year, d.month, 1) }.uniq.reverse
    else
      []
    end
  end

  def start_month_date
    @all_deliveries.last.delivery_date
  end

  def end_month_date
    @period.first.ago(1.month)
  end

  def find_event_for_date(date)
    @deliveries.find {|delivery| delivery.delivery_date == date }
  end

  def ordered_deliveries_by_period
    if @all_deliveries.any?
      @all_deliveries.delivered_in_period(@period).sort_by{|delivery| delivery.delivery_date}.reverse
    else
      []
    end
  end

  def ordered_days_till_now
    @period.to_a.reverse
  end

end
