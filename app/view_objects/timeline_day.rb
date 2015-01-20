class TimelineDay
  attr_reader :date
  extend ActiveModel::Naming

  def initialize(date, event)
    @date = date
    @event = event
  end

  def has_event?
    @event.present?
  end

  def event_content
    @event.text
  end

  def to_partial_path
    'timelines/timeline_day'
  end

  def to_key
    [@date]
  end

end
