class Admin::AdminSiteUserPresenter < Carnival::BaseAdminPresenter

  model_name 'User'

  field :id,
        actions: [:index, :show], :sortable => false

  field :email,
        actions: [:index, :show, :new, :edit], :sortable => true,
        advanced_search: {:operator => :like}

  field :role,
        actions: [:index, :show, :new, :edit], sortable: true,
        as: :enum

  action :show
  action :new
  action :destroy
  action :edit_profile, show_func: :has_profile?
  action :create_profile, show_func: :has_no_profile?

end
