module PaperTrailViews
  class Event
    attr_accessor :type, :before_change, :after_change, :date, :user

    def initialize(options = {})
      @type = options[:type]
      @before_change = options[:before_change]
      @after_change = options[:after_change]
      @date = options[:date]
      @model_class = options[:model_class]
      @user = options[:user]
    end

    def changes
      get_keys.map do |key|
        before_attribute = before_change ? before_change.send('[]', key) : nil
        after_attribute = after_change ? after_change.send('[]', key) : nil
        AttributeChange.new(attribute_name: translate_key(key), before_change: before_attribute, after_change: after_attribute)
      end
    end

    def get_keys
      ((@before_change || {}).keys | (@after_change || {}).keys).uniq
    end

    def translate_key(key)
      @model_class.human_attribute_name(key)
    end

  end
end
