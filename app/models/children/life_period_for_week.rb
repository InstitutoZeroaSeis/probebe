module Children
  class LifePeriodForWeek
    RANGES = [
      PERIOD_FOR_FIRST_TO_FOURTH_MONTH = 0..16,
      PERIOD_FOR_FIFTH_TO_EIGHTH_MONTH = 17..32,
      PERIOD_FOR_NINETH_TO_TWELFTH_MONTH = 33..48,
      PERIOD_FOR_THIRTEENTH_TO_FIFTEENTH_MONTH = 49..60
    ]

    def initialize(start_week, end_week, pregnancy)
      @start_week = start_week
      @end_week = end_week
      @pregnancy = pregnancy
    end

    def life_period
      if @pregnancy
        :pregnancy
      else
        born_period
      end
    end

    protected

    def born_period
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

    def to_compare
      if [@start_week, @end_week].include? nil
        @start_week || @end_week
      else
        smallest_distance.last
      end
    end

    def smallest_distance
      distance.sort_by(&:first).first
    end

    def distance
      RANGES.map do |range|
        smallest_from_start = min_distance_from_start_or_end(range.first)
        smallest_from_end = min_distance_from_start_or_end(range.last)
        smallest_distance = [smallest_from_start, smallest_from_end].min

        [smallest_distance, range]
      end
    end

    def min_distance_from_start_or_end(value)
      [(value - @start_week).abs, (value - @end_week).abs].min
    end
  end
end
