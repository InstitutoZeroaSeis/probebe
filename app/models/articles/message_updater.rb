module Articles
  class MessageUpdater

    def self.update_from_article(message, article)
      message.gender = article.gender
      message.teenage_pregnancy = article.teenage_pregnancy
      message.baby_target_type = article.baby_target_type
      message.minimum_valid_week = article.minimum_valid_week
      message.maximum_valid_week = article.maximum_valid_week
      message.category = article.category
      message.save!
    end

    def self.update_many_from_article(messages, article)
      messages.each do |message|
        update_from_article(message, article)
      end
    end

  end
end
