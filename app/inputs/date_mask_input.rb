class DateMaskInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options)
    if object and object.send(attribute_name)
      input_html_options[:value] = object.send(attribute_name).strftime("%d/%m/%Y")
    end
    super
  end

  def input_html_classes
    super.push('datemask')
  end
end
