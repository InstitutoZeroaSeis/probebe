class TextWithTagDataInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    merged_input_options =
      merge_wrapper_options(input_html_options, wrapper_options)
      .merge(data: { tags: all_tags })

    @builder.text_field(attribute_name, merged_input_options).html_safe
  end

  protected

  def all_tags
    Tag.all.map(&:name).join(',')
  end
end
