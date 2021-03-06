module MessageDeliveries
  class MessageMatcher
    attr_reader :messages
    attr_reader :child
    attr_reader :system_date

    def initialize(messages, child, system_date)
      @messages = messages
      @child = child
      @system_date = system_date
      @message_deliveries_of_child = message_deliveries_by(child)
    end

    def match_message_for_child
      messages = filter_messages_for_child
      return if messages.empty?

      messages = create_group_messages_for_child(messages)
      match_message_from_category(messages)
    end

    protected

    def filter_messages_for_child
      messages = filter_by_gender(@messages)
      messages = filter_by_life_period(messages)
      messages = filter_by_age(messages)
      filter_by_already_sent_message(messages)
    end

    def filter_by_gender(messages)
      if child.gender.present?
        if child.gender == 'male'
          messages.male_and_both
        else
          messages.female_and_both
        end
      else
        messages
      end
    end

    def filter_by_life_period(messages)
      life_period = child.pregnancy?(@system_date) ? 'pregnancy' : 'born'
      messages.select do |message|
        message.send("#{life_period}?")
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
        !@message_deliveries_of_child.map(&:message).include? message
      end
    end

    def create_group_messages_for_child(messages)
      messages_by_remaining_weeks =  group_by_maximum_valid_week(messages, @child)
      find_messages_with_nearest_due_date(messages_by_remaining_weeks)
    end

    def group_by_maximum_valid_week(messages, child)
      age_in_weeks = child.age_in_weeks(@system_date)
      messages.group_by do |message|
        message.remaining_weeks_till_due_date(age_in_weeks)
      end
    end

    def find_messages_with_nearest_due_date(grouped_messages)
      least_amount_key = grouped_messages.keys.min
      grouped_messages[least_amount_key]
    end

    def match_message_from_category(messages)
      category = category_for_child
      article_to_exclude = map_last_five_articles_from(child, category)
      matched_message = matched_message_by(messages, category, article_to_exclude)
      matched_message || messages.first
    end

    def category_for_child
      less_delivered_finder =
        MessageDeliveries::LessDeliveredCategoryFinder
        .new(@child.message_deliveries, map_last_two_categories_from(@child))
      less_delivered_finder.find
    end

    def map_last_two_categories_from(child)
      @message_deliveries_of_child.last(2).map do |msg|
        msg.article.category.parent_category
      end.map(&:id)
    end

    def map_last_five_articles_from(child, category)
      @message_deliveries_of_child.select do |md|
        md.message.present? && md.article.present? && md.article.category == category
      end.first(5).map { |msg| msg.article.id }
    end

    def matched_message_by(messages, category, article_to_exclude)
      messages.find do |message|
        (message.parent_category == category || message.parent_category == category.parent_category) && !article_to_exclude.include?(message.article.id)
      end
    end

    def message_deliveries_by(child)
      MessageDeliveries::MessageDelivery.eager_load(:message => {:article => {:category => :parent_category}}).where(child_id: child.id).order('message_deliveries.id DESC')
    end

  end
end
