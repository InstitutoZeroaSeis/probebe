class UserPresenter < Carnival::BaseAdminPresenter

  field :id,
        actions: [:index, :show], :sortable => false,
        advanced_search: {:operator => :equal}

  field :email,
        actions: [:index, :show], :sortable => false,
        advanced_search: {:operator => :like}

  action :show

end