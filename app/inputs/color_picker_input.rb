class ColorPickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    merged_input_options =
      merge_wrapper_options(input_html_options, wrapper_options)
      .merge(data: { minicolors: { theme: :bootstrap, position: 'right' } })

    @builder.text_field(attribute_name, merged_input_options).html_safe
  end

end
