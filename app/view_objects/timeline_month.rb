class TimelineMonth
  attr_reader :date
  extend ActiveModel::Naming

  def initialize(date)
    @date = date
  end

  def to_partial_path
    'timelines/timeline_month'
  end

  def to_key
    [@date]
  end

end
