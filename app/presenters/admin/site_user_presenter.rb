class Admin::SiteUserPresenter < Carnival::BaseAdminPresenter

  model_name 'User'

  field :id,
        actions: [:index, :show], :sortable => false

  field :email,
        actions: [:index, :show], :sortable => true,
        advanced_search: {:operator => :like}

  field :profile_name,
        actions: [:index, :show]

  field :profile_birth_date,
        actions: [:show]

  field :profile_state,
        actions: [:show]

  field :profile_city,
        actions: [:show]

  field :profile_street,
        actions: [:show]

  field :profile_primary_cell_phone_number,
        actions: [:show]

  action :show
  action :impersonate,
          remote: :false,
          method: 'POST'

end
