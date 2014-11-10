module Features
  module RegexHelper
    def extract_link_from_text(link_class, text)
      /<a class="#{link_class}" href="(.*)">/.match(text).captures.first
    end
  end
end
