module Blog
  class PostOrderByCreation
    def initialize(relation)
      @relation = relation
    end

    def order
      @relation.order(created_at: :desc)
    end
  end
end
