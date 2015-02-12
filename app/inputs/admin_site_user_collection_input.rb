class AdminSiteUserCollectionInput < SimpleForm::Inputs::CollectionSelectInput
  def input(wrapper_options)
    set_options
    super
  end

  def set_options
    options[:collection] = User.admin_site_user
    options[:label_method] = :profile_name
    options[:value_method] = :profile_id
  end
end
