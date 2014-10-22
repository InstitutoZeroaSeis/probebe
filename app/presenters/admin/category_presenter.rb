class Admin::CategoryPresenter < Carnival::BaseAdminPresenter

  field :id,
        actions: [:index, :show], :sortable => false,
        advanced_search: {:operator => :equal}

  field :name,
        actions: [:index, :show, :edit, :new],
        sortable: false,
        advanced_search: {:operator => :like}

  field :parent_category,
        sortable: false,
        actions: [:edit, :new]

  action :show
  action :edit
  action :destroy
  action :new

end