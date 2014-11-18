class ReadonlyRawInput < SimpleForm::Inputs::Base
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    content_tag(:span, merged_input_options) do
      sanitize @builder.object.send(attribute_name)
    end
  end
end
