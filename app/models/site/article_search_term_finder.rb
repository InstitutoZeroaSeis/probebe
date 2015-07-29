module Site
  class ArticleSearchTermFinder
    def initialize(term, relation)
      @term = term
      @relation = relation
    end

    def find
      @relation.joins(:tags).where(match_title.or(match_text.or(match_tag_name))).uniq
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

    def match_tag_name
      Tag.arel_table[:name].matches("%#{@term}%")
    end
  end
end
