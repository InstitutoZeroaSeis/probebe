module MessageDeliveries
  class MessageMatcher
    attr_reader :messages
    attr_reader :child
    attr_reader :profile
    attr_reader :system_date

    def initialize(messages, child, system_date)
      @messages = messages
      @child = child
      @profile = @child.profile
      @system_date = system_date
    end

    def find_message_for_child
      messages = filter_by_gender(@messages, @child)
      messages = filter_by_life_period(messages)
      messages = filter_by_age(messages)
      messages = filter_by_already_sent_message(messages, @profile)
      order_by_ending_valid_date(messages, child)
    end

    def any_message_found?
      find_message_for_child.size > 0
    end

    protected

    def filter_by_already_sent_message(messages, profile)
      messages.to_a.select do |message|
        message.message_already_sent_for_profile(profile)
      end
    end

    def filter_by_gender(messages, child)
      if @child.gender.present?
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
