class WeekToDateInput < SimpleForm::Inputs::Base
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  def input(wrapper_options)
    content_tag :div, class: 'form-group' do
      content_tag :div, class: 'input-group' do
        hidden_field +
          number_field(wrapper_options) +
          content_tag(:div, class: 'input-group-addon') { I18n.t('general.commom_words.weeks') }
      end
    end
  end

  def hidden_field
    @builder.hidden_field(attribute_name)
  end

  def number_field(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    merged_input_options[:class] ||= []
    merged_input_options[:class] << ' week_to_date'
    number_field_tag("#{attribute_name}", get_date_in_weeks, merged_input_options)
  end

  def get_date_in_weeks
    attr_value = object.send(attribute_name)
    if object and attr_value
      (Date.today - attr_value).to_i / 7
    end
  end
end
