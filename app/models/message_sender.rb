class MessageSender
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def send_messages
    profiles = get_profiles
    message_delivery = MessageDelivery.create!(message: message, profiles: profiles)
  end

  def get_profiles
    profile_finder = ProfileFinder.new(message)
    profile_finder.find_profiles_by_message.map &:profile
  end

end
