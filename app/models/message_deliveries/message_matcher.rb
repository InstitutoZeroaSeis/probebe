module MessageDeliveries
  class MessageMatcher
    attr_reader :messages
    attr_reader :child
    attr_reader :system_date

    def initialize(messages, child, system_date)
      @messages = messages
      @child = child
      @system_date = system_date
    end

    def match_message_for_child
      messages = filter_messages_for_child
      if messages.present?
        messages = find_group_messages_for_child(messages)
        match_message_from_category(messages)
      end
    end

    def filter_messages_for_child
      messages = filter_by_gender(@messages)
      messages = filter_by_life_period(messages)
      messages = filter_by_age(messages)
      filter_by_already_sent_message(messages)
    end

    protected

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
      messages.select do |message|
        message.age_valid_for_message?(age_in_weeks)
      end
    end

    def filter_by_already_sent_message(messages)
      messages.select do |message|
        !child.message_deliveries.map(&:message).include? message
      end
    end

    def find_group_messages_for_child(messages)
      messages_by_remaining_weeks =  group_by_maximum_valid_week(messages, @child)
      find_messages_with_nearest_due_date(messages_by_remaining_weeks)
    end

    def group_by_maximum_valid_week(messages, child)
      age_in_weeks = child.age_in_weeks(@system_date)
      messages.group_by {|message| message.remaining_weeks_till_due_date(age_in_weeks) }
    end

    def find_messages_with_nearest_due_date(grouped_messages)
      least_amount_key = grouped_messages.keys.min
      grouped_messages[least_amount_key]
    end

    def match_message_from_category(messages)
      category = category_for_child
      matched_message = messages.find do |message|
        message.parent_category == category
      end
      matched_message || messages.first
    end

    def category_for_child
      category_matcher = MessageDeliveries::CategoryMatcher.new(@child)
      category = category_matcher.find_least_delivered_category
    end
  end
end
