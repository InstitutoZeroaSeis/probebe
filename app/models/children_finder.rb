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
      message.age_valid_for_message?(child.age_in_weeks)
    end
  end

end
