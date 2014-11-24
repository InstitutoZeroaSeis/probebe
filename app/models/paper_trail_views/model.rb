module PaperTrailViews
  class Model
    attr_reader :model_instance

    def initialize(model_instance)
      @model_instance = model_instance
    end

    def self.all
      distintict_versions.map do |version|
        new find_model(version)
      end
    end

    def ==(other)
      return self.model_instance == other.model_instance
    end

    protected

    def self.find_model(version)
      version.item_type.constantize.find(version.item_id)
    rescue ActiveRecord::RecordNotFound
      version.reify
    end

    def self.distintict_versions
      PaperTrail::Version.group(:item_type, :item_id)
    end

  end
end
