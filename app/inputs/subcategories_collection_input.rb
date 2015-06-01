class SubcategoriesCollectionInput < SimpleForm::Inputs::CollectionSelectInput
  def input(wrapper_options)
    set_options
    super
  end

  protected

  def set_options
    options[:collection] = Category.sub_categories
    options[:label_method] = :name
    options[:value_method] = :id
  end
end
