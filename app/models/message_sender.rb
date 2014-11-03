class MessageSender
  attr_reader :message

  def initialize(profile_finder)
    @message = profile_finder.message
    @profile_finder = profile_finder
  end

  def send_messages
    profiles = get_profiles
    message_delivery = MessageDelivery.create!(message: message, profiles: profiles)
  end

  protected

  def get_profiles
    profiles = @profile_finder.find_profiles_by_message
    filter_already_sent_messages(profiles)
  end

  def filter_already_sent_messages(profiles)
    profiles.select do |profile|
      profile.message_deliveries.none? do |delivery|
        @message == delivery.message
      end
    end
  end
end
