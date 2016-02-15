module Articles
  class TagByNameCreator
    def initialize(tag_names)
      @tag_names = tag_names
    end

    def find_or_create_tags
      @tag_names.map do |tag_name|
        Tag.find_or_create_by(name: tag_name)
      end
    end
  end
end
