module Site
  class ArticleSearchTermFinder
    def initialize(term, relation)
      @term = term
      @relation = relation
    end

    def find
      @relation.where(match_title.or(match_text))
    end

    protected

    def match_title
      table[:title].matches("%#{@term}%")
    end

    def match_text
      table[:text].matches("%#{@term}%")
    end

    def table
      Article.arel_table
    end
  end
end
