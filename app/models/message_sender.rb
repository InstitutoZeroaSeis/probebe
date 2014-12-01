class MessageSender
  attr_reader :child

  def initialize(messages_finder)
    @child = messages_finder.child
    @messages_finder = messages_finder
  end

  def send_messages
    random_message = get_random_message
    message_delivery = MessageDelivery.create!(message: random_message, profile: @child.profile)
  end

  protected

  def get_messages
    messages = @messages_finder.find_message_for_child
  end

  def get_random_message
    get_messages.sample
  end
end
