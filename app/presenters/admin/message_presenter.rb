
class Admin::MessagePresenter < Carnival::BaseAdminPresenter

  field :id,
    actions: [:index, :show], :sortable => false,
    advanced_search: {:operator => :equal}

  field :text,
    actions: [:index, :new, :edit, :show],
    advanced_search: {:operator => :like}


  field :created_at, :actions => [:index, :show]

  action :show
  action :edit
  action :destroy
  action :new

end
