module MessageDeliveries
  class MessageFilter
    attr_reader :messages
    attr_reader :child
    attr_reader :system_date

    def initialize(messages, child, system_date)
      @messages = messages
      @child = child
      @system_date = system_date
    end

    def filter_message_for_child
      messages = filter_by_gender(@messages)
      messages = filter_by_life_period(messages)
      messages = filter_by_age(messages)
      messages = filter_by_already_sent_message(messages)
      order_by_ending_valid_date(messages, child)
    end

    protected

    def filter_by_already_sent_message(messages)
      messages.to_a.select do |message|
        !child.message_deliveries.map(&:message).include? message
      end
    end

    def filter_by_gender(messages)
      if child.gender.present?
        child.gender == 'male' ? messages.send('male_and_both') : messages.send('female_and_both')
      else
        messages
      end
    end

    def filter_by_life_period(messages)
      gender = child.pregnancy?(@system_date) ? 'pregnancy' : 'born'
      messages.select do |message|
        message.send("#{gender}?")
      end
    end

    def filter_by_age(messages)
      age_in_weeks = child.age_in_weeks(@system_date)
      messages.to_a.select do |message|
        message.age_valid_for_message?(age_in_weeks)
      end
    end

    def order_by_ending_valid_date(messages, child)
      age_in_weeks = child.age_in_weeks(@system_date)
      messages.sort_by {|message| message.distance_for_maximum_valid_week(age_in_weeks)}
    end

  end
end
