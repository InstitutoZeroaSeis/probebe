class Admin::UserPresenter < Carnival::BaseAdminPresenter

  field :id,
        actions: [:index, :show], :sortable => false

  field :email,
        actions: [:index, :show], :sortable => true,
        advanced_search: {:operator => :like}


  action :show
  action :impersonate,
          remote: :true,
          method: 'POST'

end