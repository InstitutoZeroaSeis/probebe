class Admin::CategoryPresenter < Carnival::BaseAdminPresenter

  field :id,
        actions: [:index, :show], :sortable => false,
        advanced_search: {:operator => :equal}

  field :parent_category,
        as: :enum,
        actions: [:index, :show, :edit, :new]

  field :name,
        actions: [:index, :show, :edit, :new],
        sortable: false,
        advanced_search: {:operator => :like}

  action :show
  action :edit
  action :destroy
  action :new

end
