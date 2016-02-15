module Site
  class ArticleOrderByCreation
    def initialize(relation)
      @relation = relation
    end

    def sort
      @relation.order(created_at: :desc)
    end
  end
end
