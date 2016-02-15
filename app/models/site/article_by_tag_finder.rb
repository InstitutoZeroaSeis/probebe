module Site
  class ArticleByTagFinder
    def initialize(tag_id, relation)
      @tag_id = tag_id
      @relation = relation
    end

    def find
      if @tag_id
        @relation.joins(:tags).merge(Tag.where(id: @tag_id))
      else
        @relation
      end
    end
  end
end
