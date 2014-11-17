class CharCountableInput < SimpleForm::Inputs::TextInput
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  def input(wrapper_options)
    super + content_tag(:span) do
      content_tag(:span, class: "char_count") { "(0)" } + " caracter(es)"
    end
  end

  def input_html_classes
    super.push('countable')
  end

  def input_html_options
    base_options = super
    base_options[:onkeydown] = 'countChar(event)'
    base_options[:onkeyup] = 'countChar(event)'
    base_options[:onfocus] = 'countChar(event)'
    base_options
  end
end
