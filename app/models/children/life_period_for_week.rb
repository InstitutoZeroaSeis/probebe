module Children
  class LifePeriodForWeek
    RANGES = [
      PERIOD_FOR_FIRST_TO_FOURTH_MONTH = 0..16,
      PERIOD_FOR_FIFTH_TO_EIGHTH_MONTH = 17..32,
      PERIOD_FOR_NINETH_TO_TWELFTH_MONTH = 33..48,
      PERIOD_FOR_THIRTEENTH_TO_FIFTEENTH_MONTH = 49..60
    ]

    def initialize(start_week, end_week)
      @start_week = start_week
      @end_week = end_week
    end

    def life_period
      case to_compare
      when PERIOD_FOR_FIRST_TO_FOURTH_MONTH
        :first_to_fourth
      when PERIOD_FOR_FIFTH_TO_EIGHTH_MONTH
        :fifth_to_eighth
      when PERIOD_FOR_NINETH_TO_TWELFTH_MONTH
        :nineth_to_twelfth
      when PERIOD_FOR_THIRTEENTH_TO_FIFTEENTH_MONTH
        :thirteenth_to_fifteenth
      else
        :thirteenth_to_fifteenth
      end
    end

    protected

    def to_compare
      if [@start_week, @end_week].include? nil
        @start_week || @end_week
      else
        most_common_range.last
      end
    end

    def most_common_range
      common_items_in_range.sort_by(&:first).last
    end

    def common_items_in_range
      RANGES.map do |range|
        common_items = range.to_a & (@start_week..@end_week).to_a
        [common_items, range]
      end
    end
  end
end
