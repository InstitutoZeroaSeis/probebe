class WeekToDateInput < SimpleForm::Inputs::Base
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  def input(wrapper_options)
    content_tag :div, class: 'form-group' do
      content_tag :div, class: 'input-group' do
        datepicker_field +
        week_to_date_content(wrapper_options)
      end
    end
  end

  def datepicker_field
    input_html_options[:value] = object.send(attribute_name)
    @builder.input attribute_name, as: :date_picker, input_html: input_html_options
  end

  def week_to_date_content(wrapper_options)
    content_tag :div, class: 'week_to_date_number' do
      number_field(wrapper_options) +
      content_tag(:div, class: 'input-group-addon') { I18n.t('general.commom_words.weeks') }
    end
  end

  def number_field(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    merged_input_options[:class] ||= []
    merged_input_options[:class] << ' week_to_date_number'
    merged_input_options[:onchange] = 'setDateFromWeek(event)'

    number_field_tag("#{attribute_name}", get_date_in_weeks, merged_input_options)
  end

  def get_date_in_weeks
    attr_value = object.send(attribute_name)
    if object and attr_value
      (Date.today - attr_value).to_i / 7
    end
  end
end
