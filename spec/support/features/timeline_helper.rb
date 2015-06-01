module Features
  module TimelineHelper
    def within_timeline_date(date, &block)
      date = date.strftime('%Y-%m-%d')
      within "li#timeline_day_#{date}.timeline-steps .day-data", &block
      within_timeline date do
        within '.day-data', &block
      end
    end

    def within_timeline(date, &block)
      within "li#timeline_day_#{date}.timeline-steps", &block
    end

    def have_day_with_text(text)
      have_css('.day', text: text)
    end

    def have_day_without_text
      have_css('.day', text: '')
    end

    def day_with_leading_zero(date)
      date.strftime('%d').rjust(2, '0')
    end

    def have_message_with_link_to_post(text, href)
      have_link(text, href: href)
    end

    def not_have_message_with_link_to_post(link_content)
      have_link(link_content, href: '#')
    end
  end
end
