module Articles
  class JournalisticArticleFactory
    def self.from_authorial_article(authorial_article)
      Articles::JournalisticArticleWithCover.new do |a|
        properties = [:baby_target_type, :category_id, :gender,
                      :minimum_valid_week, :maximum_valid_week,
                      :tags, :teenage_pregnancy]

        copy_properties(authorial_article, a, properties)

        a.original_author = authorial_article.user
        a.parent_article = authorial_article
        authorial_article.messages.each do |message|
          a.messages << Message.new(text: message.text)
        end
      end
    end

    protected

    def self.copy_properties(from, to, properties)
      properties.each do |prop|
        to.send("#{prop}=", from.send(prop))
      end
    end
  end
end
