class Admin::SiteUserPresenter < Carnival::BaseAdminPresenter

  model_name 'User'

  field :id,
        actions: [:index, :show], :sortable => false

  field :email,
        actions: [:index, :show], :sortable => true,
        advanced_search: {:operator => :like}

  action :show
  action :impersonate,
          remote: :false,
          method: 'POST'

end
