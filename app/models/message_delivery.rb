class MessageDelivery
  attr_accessor :children

  def initialize(children = [])
    @children = children
  end

  def ==(other)
    @children.to_set == other.children.to_set
  end

end
