class AdminSiteUserCollectionInput < SimpleForm::Inputs::CollectionSelectInput
  def input(wrapper_options)
    set_options
    super
  end

  def set_options
    options[:collection] = User.admin_site_user
  end
end
