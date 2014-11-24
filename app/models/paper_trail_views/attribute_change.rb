module PaperTrailViews
  class AttributeChange
    attr_accessor :attribute_name, :before_change, :after_change

    def initialize(options = {})
      @attribute_name = options[:attribute_name]
      @before_change = options[:before_change]
      @after_change = options[:after_change]
    end

    def has_changed?
      current_value != previous_value
    end
  end

end
