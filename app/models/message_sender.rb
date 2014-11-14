class MessageSender
  attr_reader :article

  def initialize(profile_finder)
    @article = profile_finder.article
    @profile_finder = profile_finder
  end

  def send_messages
    profiles = get_profiles
    @article.messages.each do |message|
      profiles_without_message = filter_already_sent_messages(message, profiles)
      message_delivery = MessageDelivery.create!(message: message, profiles: profiles_without_message)
    end
  end

  protected

  def get_profiles
    profiles = @profile_finder.find_profiles_by_article
  end

  def filter_already_sent_messages(message, profiles)
    profiles.select do |profile|
      profile.message_deliveries.none? do |delivery|
        message == delivery.message
      end
    end
  end
end
