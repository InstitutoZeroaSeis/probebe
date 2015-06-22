module Blog
  class PostByAuthorFinder
    def initialize(author_id, relation)
      @author_id = author_id
      @relation = relation
    end

    def find
      return @relation unless @author_id
      @relation.where(original_author_id: @author_id)
    end
  end
end
