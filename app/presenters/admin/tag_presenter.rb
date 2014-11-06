class Admin::TagPresenter < Carnival::BaseAdminPresenter

  field :id,
        actions: [:index, :show],
        sortable: true

  field :name,
        actions: [:index, :show, :new, :edit],
        advanced_search: {operator: :like}

  action :show
  action :edit
  action :destroy
  action :new

end