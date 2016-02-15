module PaperTrailViews
  class ActivityLog
    def initialize(model_class, model_id)
      @model_class = model_class
      @model_id = model_id
    end

    def events
      @events ||= model.versions.map do |version|
        build_version(version)
      end
    end

    def events_count
      model.versions.size
    end

    def model_name
      @model_class.model_name.human
    end

    protected

    def model
      @model ||= @model_class.find(@model_id)
    end

    def build_version(version)
      previous_attributes, after_attributes = get_version_attributes(version)
      Event.new(type: version.event, before_change: previous_attributes,
                after_change: after_attributes, date: version.created_at,
                model_class: @model_class, user: version.whodunnit)
    end

    def get_version_attributes(version)
      if version.next == nil and version.event != 'create'
        previous_attributes = version.reify(dup: true).attributes
        after_attributes = model.attributes
      else
        previous_attributes = version.previous ? version.previous.reify(dup: true).try(:attributes) : nil
        after_attributes = version.object ? YAML.load(version.object) : model.attributes
      end
      [previous_attributes, after_attributes]
    end
  end

end
