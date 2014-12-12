class Admin::UserPresenter < Carnival::BaseAdminPresenter

  field :email,
        actions: [:index, :show], :sortable => true,
        advanced_search: {:operator => :like}
end
