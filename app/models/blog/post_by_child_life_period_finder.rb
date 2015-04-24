module Blog
  class PostByChildLifePeriodFinder
    def initialize(life_period, relation)
      @life_period = life_period
      @relation = relation
    end

    def find
      if @life_period
        @relation.send(@life_period)
      else
        @relation
      end
    end
  end
end
