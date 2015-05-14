module Articles
  class TagSplitter
    def initialize(tag_text)
      @tag_text = tag_text
    end

    def split_by_comma
      @tag_text
        .split(',')
        .map(&:strip)
        .select(&:present?)
    end
  end
end
