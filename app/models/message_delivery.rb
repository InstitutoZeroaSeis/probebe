class MessageDelivery
  attr_accessor :children
  attr_accessor :message

  def initialize(message, children = [])
    @message = message
    @children = children
  end

  def ==(other)
    @message == other.message and
      @children.to_set == other.children.to_set
  end

end
