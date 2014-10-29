class MessageSender

  def send_messages
    Message.all.map do |message|
      delivery = MessageDelivery.new
      delivery.children = find_childrens_for_message(message)
      delivery
    end
  end

  protected

  def find_childrens_for_message(message)
    children = filter_by_born_state(message)
    children = filter_by_gender(message, children)
    children = filter_by_age(message, children)
  end

  def filter_by_born_state(message, children=Child.all)
    Child.where(born: message.pregnancy? ? false: true)
  end

  def filter_by_gender(message, children=Child.all)
    if message.gender != 'both'
      children.send(message.gender)
    else
      children
    end
  end

  def filter_by_age(message, children)
    children.to_a.select do |child|
      min_week = message.minimum_valid_week || 0
      max_week = message.maximum_valid_week || Message::MAXIMUM_POSSIBLE_WEEK
      (min_week..max_week).include? child.age_in_weeks
    end
  end
end
