module Blog
  class PostByTagFinder
    def initialize(tag_name, relation)
      @tag_name = tag_name
      @relation = relation
    end

    def find
      if @tag_name
        @relation.joins(:tags).merge(Tag.where(name: @tag_name))
      else
        @relation
      end
    end
  end
end
