class CategoryGroupedSelectInput < SimpleForm::Inputs::GroupedCollectionSelectInput
  def input(wrapper_options)
    set_options
    super
  end

  def set_options
    options[:collection] = Category.super_categories.order(:name).includes(:sub_categories)
    options[:group_method] = :sub_categories
    options[:group_label_method] = :name
  end
end
