class ChildrenFinder
  attr_reader :children
  attr_reader :message

  def initialize(message, children)
    @message = message
    @children = children
  end

  def find_childrens_for_message
    children = filter_by_gender(@children)
    filter_by_age(children)
  end

  def any_children_found?
    find_childrens_for_message.size > 0
  end

  protected

  def filter_by_gender(children)
    if @message.gender != 'both'
      children.send(@message.gender)
    else
      children
    end
  end

  def filter_by_age(children)
    children.to_a.select do |child|
      min_week = @message.minimum_valid_week || 0
      max_week = @message.maximum_valid_week || Message::MAXIMUM_POSSIBLE_WEEK
      (min_week..max_week).include? child.age_in_weeks
    end
  end

end
