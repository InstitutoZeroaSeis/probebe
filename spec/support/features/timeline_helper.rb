module Features
  module TimelineHelper
    def within_timeline_date(date, &block)
      date = date.strftime("%Y-%m-%d")
      within "li#timeline_day_#{date}.timeline-steps .day-data", &block
    end

    def have_day_with_text(text)
      have_css('.day', text: text)
    end

    def have_day_without_text
      have_css('.day', text: '')
    end

    def day_with_leading_zero(date)
      date.strftime("%d").rjust(2, '0')
    end
  end
end
