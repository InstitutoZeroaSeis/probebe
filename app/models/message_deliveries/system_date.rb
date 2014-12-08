module MessageDeliveries
  class SystemDate

    attr_reader :date

    def initialize(date = nil)
      @date = date.to_date if date.present?
    end

    def date
      @date || Date.today
    end

  end
end
