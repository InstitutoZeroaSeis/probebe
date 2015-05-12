module Articles
  class JournalisticArticleFactory
    PROPERTIES = [
      :baby_target_type, :category_id, :gender,
      :minimum_valid_week, :maximum_valid_week,
      :tags, :teenage_pregnancy, :text, :title
    ]

    def initialize(authorial_article)
      @authorial_article = authorial_article
    end

    def build
      Articles::JournalisticArticleWithCover.new do |a|
        copy_properties(a)

        a.original_author = @authorial_article.user
        a.parent_article = @authorial_article

        @authorial_article.messages.each do |message|
          a.messages << Message.new(text: message.text)
        end
      end
    end

    protected

    def copy_properties(to)
      PROPERTIES.each do |prop|
        to.send("#{prop}=", @authorial_article.send(prop))
      end
    end
  end
end
