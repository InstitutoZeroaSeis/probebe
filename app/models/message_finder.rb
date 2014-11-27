class MessageFinder
  attr_reader :articles_finder
  attr_reader :child
  attr_reader :profile

  def initialize(articles_finder)
    @articles_finder = articles_finder
    @child = articles_finder.child
    @profile = @child.profile
  end

  def find_message_for_child
    messages = get_all_messages_from_articles(get_articles)
    filter_by_already_sent_message(messages, profile)
  end

  def any_message_found?
    find_message_for_child.size > 0
  end

  protected

  def get_articles
    @articles_finder.find_articles_for_child
  end

  def get_all_messages_from_articles(articles)
    articles.map(&:messages).flatten
  end

  def filter_by_already_sent_message(messages, profile)
    messages.to_a.select do |message|
      message.message_already_sent_for_profile(profile)
    end
  end
end
