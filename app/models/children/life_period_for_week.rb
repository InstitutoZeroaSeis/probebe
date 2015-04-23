module Children
  class LifePeriodForWeek
    PERIOD_FOR_FIRST_TO_FOURTH_MONTH = 0..16
    PERIOD_FOR_FIFTH_TO_EIGHTH_MONTH = 17..32
    PERIOD_FOR_NINETH_TO_TWELFTH_MONTH = 33..48
    PERIOD_FOR_THIRTEENTH_TO_FIFTEENTH_MONTH = 49..60

    def initialize(min_week, max_week, pregnancy)
      @min_week = min_week
      @max_week = max_week
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
      case @min_week || @max_week
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
  end
end
