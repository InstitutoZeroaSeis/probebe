class ReadonlyInput < SimpleForm::Inputs::Base
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Context

  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    content_tag(:span, parsed_attribute_value, merged_input_options)
  end

  protected

  def parsed_attribute_value
    if attribute_is_enum? || attribute_is_boolean?
      opts = translate_from_namespace(:options).stringify_keys
      opts.send('[]', attribute_value.to_s)
    else
      attribute_value
    end
  end

  def attribute_value
    @builder.object.send(attribute_name) if @builder.object
  end

  def attribute_is_enum?
    @builder.object.defined_enums[attribute_name]
  end

  def attribute_is_boolean?
    attribute_value.is_a?(TrueClass) ||
      attribute_value.is_a?(FalseClass)
  end

end
