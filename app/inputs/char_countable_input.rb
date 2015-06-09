class CharCountableInput < SimpleForm::Inputs::TextInput
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  def input(wrapper_options)
    super + content_tag(:span) do
      content_tag(:span, class: 'char_count') do
        "(#{char_count})"
      end + ' caracter(es)'
    end
  end

  protected

  def char_count
    attribute_value = object.try(attribute_name)
    return 0 if attribute_value.blank?
    attribute_value.length
  end

  def input_html_classes
    super.push('countable')
  end

  def input_html_options
    super.tap do |options|
      options[:onkeydown] = 'countChar(event)'
      options[:onkeyup] = 'countChar(event)'
      options[:onfocus] = 'countChar(event)'
    end
  end
end
