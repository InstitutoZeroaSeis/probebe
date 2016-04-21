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

  field :profile_fields,
        actions: [:new, :edit],
        as: :partial

  action :show
  action :new
  action :destroy
  action :edit_profile

end
