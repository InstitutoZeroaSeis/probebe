class MessageSender
  attr_reader :messages

  def initialize(messages)
    @messages = messages
  end

  def send_messages
  end

  def get_profiles
    messages.each do |message|
      profile_finder = ProfileFinder.new(message)
      profile_finder.find_profiles_by_message
    end
  end
  protected

end
