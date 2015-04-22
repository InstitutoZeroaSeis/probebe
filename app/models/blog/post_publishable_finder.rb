module Blog
  class PostPublishableFinder
    def initialize(relation)
      @relation = relation
    end

    def find
      @relation.where(publishable: true)
    end
  end
end
