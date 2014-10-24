class EnumInput < SimpleForm::Inputs::CollectionSelectInput

  def input
    options[:collection] ||= get_collection
    super
  end

  def get_collection
    object.class.const_get(constant_name)
  end

  def constant_name
    "#{attribute_name.upcase}_ENUM"
  end

end
